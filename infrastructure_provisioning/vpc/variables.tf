variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "cluster-name" {
  default = "cats-cluster"
  type    = string
}

variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "rds_sg"
  description = "Tag Name for sg"
}

variable "public_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet"
}

variable "public_subnet_az" {
  default     = "us-east-1a"
  description = "Public Subnet Availability Zone"
}

variable "private_subnet1_cidr" {
  default     = "10.0.2.0/24"
  description = "Private Subnet"
}

variable "private_subnet2_cidr" {
  default     = "10.0.32.0/24"
  description = "Private Subnet"
}

variable "private_subnet_az" {
  default     = "us-east-1b"
  description = "Public Subnet Availability Zone"
}

variable "az_1" {
  default     = "us-east-1b"
  description = "Your Az1, use AWS CLI to find your account specific"
}

variable "az_2" {
  default     = "us-east-1c"
  description = "Your Az2, use AWS CLI to find your account specific"
}
