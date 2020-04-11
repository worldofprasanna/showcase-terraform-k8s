variable "cluster-name" {
  default = "cats-cluster"
  type    = string
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR"
}

variable "public_subnet1_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet"
}

variable "public_subnet2_cidr" {
  default     = "10.0.64.0/24"
  description = "Public Subnet"
}

variable "private_subnet1_cidr" {
  default     = "10.0.2.0/24"
  description = "Private Subnet"
}

variable "private_subnet2_cidr" {
  default     = "10.0.32.0/24"
  description = "Private Subnet"
}

variable "public_subnet1_az" {
  default     = "us-east-1a"
  description = "Public Subnet Availability Zone"
}

variable "public_subnet2_az" {
  default     = "us-east-1b"
  description = "Public Subnet Availability Zone"
}

variable "private_subnet1_az" {
  default     = "us-east-1a"
  description = "Public Subnet Availability Zone"
}

variable "private_subnet2_az" {
  default     = "us-east-1b"
  description = "Public Subnet Availability Zone"
}

variable "nat_availability_zone" {
  default     = "us-east-1a"
  description = "NAT Instance availability zone"
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "environment" {
  default = "stg"
  type    = string
}
