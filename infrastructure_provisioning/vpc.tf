#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "cats" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "terraform-eks-cats-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "cats" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.cats.id

  tags = map(
    "Name", "terraform-eks-cats-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "cats" {
  vpc_id = aws_vpc.cats.id

  tags = {
    Name = "terraform-eks-cats"
  }
}

resource "aws_route_table" "cats" {
  vpc_id = aws_vpc.cats.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cats.id
  }
}

resource "aws_route_table_association" "cats" {
  count = 2

  subnet_id      = aws_subnet.cats.*.id[count.index]
  route_table_id = aws_route_table.cats.id
}