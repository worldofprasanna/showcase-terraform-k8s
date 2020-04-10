# Main - VPC
resource "aws_vpc" "cats" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "Cats",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

# Create IGW
resource "aws_internet_gateway" "cats" {
  vpc_id = aws_vpc.cats.id

  tags = {
    Name = "Cats IGW"
  }
}

# Route table entry for public subnet
resource "aws_route_table" "cats" {
  vpc_id = aws_vpc.cats.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cats.id
  }
}

# Create public subnet

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${var.public_subnet_az}"

    tags = map(
      "Name", "Cats Public Subnet",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
}

# Route table for public subnet
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.cats.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.cats.id}"
    }

    tags = {
        Name = "Cats Public Subnet"
    }
}

# Attach public route table to public subnet
resource "aws_route_table_association" "public" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.public.id}"
}

# Create NAT Instance in public subnet
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet1_cidr}", "${var.private_subnet2_cidr}"]
    }

    egress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.cats.id}"

    tags = {
        Name = "Cats NAT SG"
    }
}

# NAT Instance
resource "aws_instance" "nat" {
    ami = "ami-058436d7e072250b3" # this is a special ami preconfigured to do NAT
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "Cats NAT Instance"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}

# Create private subnet
resource "aws_subnet" "private1" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.private_subnet1_cidr}"
    availability_zone = "${var.private_subnet_az}"

    tags = {
        Name = "Cats Private Subnet 1"
    }
}

resource "aws_subnet" "private2" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.private_subnet2_cidr}"
    availability_zone = "${var.private_subnet_az}"

    tags = {
        Name = "Cats Private Subnet 2"
    }
}

# Route table entry for private subnet
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.cats.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags = {
        Name = "Cats Private Subnet"
    }
}

# Attach private route table to private subnet
resource "aws_route_table_association" "private1" {
    subnet_id = "${aws_subnet.private1.id}"
    route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private2" {
    subnet_id = "${aws_subnet.private2.id}"
    route_table_id = "${aws_route_table.private.id}"
}

# Create (api, web) security group to allow public access
resource "aws_security_group" "web" {
    name = "sg_for_web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet1_cidr}", "${var.private_subnet2_cidr}"]
    }

    vpc_id = "${aws_vpc.cats.id}"

    tags = {
        Name = "WebServerSG"
    }
}

# Create (db) security group to allow access only from (api, web) security group
resource "aws_security_group" "db" {
    name = "sg_for_db"
    description = "Allow incoming database connections."

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = ["${aws_security_group.web.id}"]
    }

    egress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.cats.id}"

    tags = {
        Name = "DBServerSG"
    }
}