variable "storage" {
  default = "10"
  type    = string
}

variable "instance_class" {
  default = "db.t2.micro"
  type    = string
}

variable "security_group_id" {
  default = "sg-03b4d0becda436dab"
  type    = string
}

variable "private_subnet1_id" {
  default = "subnet-0e0276ecbe027c58e"
  type    = string
}

variable "private_subnet2_id" {
  default = "subnet-0ccebf175c20db413"
  type    = string
}


variable "username" {
  default = "postgres"
  type    = string
}

variable "password" {
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}