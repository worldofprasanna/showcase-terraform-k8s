variable "cluster-name" {
  default = "nd-app2-cluster"
  type    = string
}

variable "vpc_id" {
  type    = string
  default = "vpc-0c98edf5da40d66d3"
}

variable "public_subnet1_id" {
  type    = string
  default = "subnet-04c0152d6b054875c"
}

variable "public_subnet2_id" {
  type    = string
  default = "subnet-08d289b1c7a432d59"
}

variable "web_security_group_id" {
  type    = string
  default = "sg-0b55fe33264f2dc2e"
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
  default = "2"
  type    = number
}

variable "eks_worker_desired_nodes" {
  default = "1"
  type    = number
}

variable "environment" {
  default = "tryout"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}
