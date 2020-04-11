# Main - VPC
resource "aws_vpc" "cats" {
  cidr_block = "${var.vpc_cidr}"

  tags = map(
    "Name", "Cats",
    "kubernetes.io/cluster/${var.environment}-${var.cluster-name}", "shared",
  )
}

# Create IGW
resource "aws_internet_gateway" "cats" {
  vpc_id = aws_vpc.cats.id

  tags = {
    Name = "${var.environment} Cats IGW"
  }
}

# Create public subnet

resource "aws_subnet" "public1" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "${var.public_subnet1_az}"

    tags = map(
      "Name", "${var.environment} Cats Public Subnet 1",
      "kubernetes.io/cluster/${var.environment}-${var.cluster-name}", "shared",
    )
}

resource "aws_subnet" "public2" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.public_subnet2_cidr}"
    availability_zone = "${var.public_subnet2_az}"

    tags = map(
      "Name", "${var.environment} Cats Public Subnet 2",
      "kubernetes.io/cluster/${var.environment}-${var.cluster-name}", "shared",
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
        Name = "${var.environment} Cats Public Route Table"
    }
}

# Attach public route table to public subnet
resource "aws_route_table_association" "public1" {
    subnet_id = "${aws_subnet.public1.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public2" {
    subnet_id = "${aws_subnet.public2.id}"
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
        Name = "${var.environment} Cats NAT SG"
    }
}

# NAT Instance
resource "aws_instance" "nat" {
    ami = "ami-058436d7e072250b3" # this is a special ami preconfigured to do NAT
    availability_zone = "${var.nat_availability_zone}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.public1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "${var.environment} Cats NAT Instance"
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
    availability_zone = "${var.private_subnet1_az}"

    tags = {
        Name = "${var.environment} Cats Private Subnet 1"
    }
}

resource "aws_subnet" "private2" {
    vpc_id = "${aws_vpc.cats.id}"

    cidr_block = "${var.private_subnet2_cidr}"
    availability_zone = "${var.private_subnet2_az}"

    tags = {
        Name = "${var.environment} Cats Private Subnet 2"
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
        Name = "${var.environment} Cats Private Subnet"
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
    name = "${var.environment}-Web-SG"
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

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.cats.id}"

    tags = {
        Name = "${var.environment} WebServerSG"
    }
}

# Create (db) security group to allow access only from (api, web) security group
resource "aws_security_group" "db" {
    name = "${var.environment}-DB-SG"
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