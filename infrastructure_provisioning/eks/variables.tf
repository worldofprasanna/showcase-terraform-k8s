variable "cluster-name" {
  default = "cats-cluster"
  type    = string
}

variable "vpc_id" {
  type    = string
}

variable "public_subnet1_id" {
  type    = string
}

variable "public_subnet2_id" {
  type    = string
}

variable "web_security_group_id" {
  type    = string
}

variable "eks_worker_instance_type" {
  default = "t3.medium"
  type    = string
}

variable "eks_worker_min_nodes" {
  default = "1"
  type    = number
}

variable "eks_worker_max_nodes" {
  default = "1"
  type    = number
}

variable "eks_worker_desired_nodes" {
  default = "1"
  type    = number
}

variable "environment" {
  default = "stg"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}
