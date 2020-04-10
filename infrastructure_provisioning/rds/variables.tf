variable "storage" {
  default = "10"
  type    = string
}

variable "instance_class" {
  default = "db.t2.micro"
  type    = string
}

variable "security_group_id" {
  type    = string
}

variable "private_subnet1_id" {
  type    = string
}

variable "private_subnet2_id" {
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