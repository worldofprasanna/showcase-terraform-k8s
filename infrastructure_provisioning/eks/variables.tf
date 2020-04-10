variable "cluster-name" {
  default = "cats-cluster"
  type    = string
}

variable "vpc_id" {
  default = "vpc-033a57f3990a8ede3"
  type    = string
}

variable "public_subnet1_id" {
  default = "subnet-09f86b35b07f60539"
  type    = string
}

variable "public_subnet2_id" {
  default = "subnet-036ab29537294c635"
  type    = string
}

variable "security_group_id" {
  default = "sg-0ee25147027b03307"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}
