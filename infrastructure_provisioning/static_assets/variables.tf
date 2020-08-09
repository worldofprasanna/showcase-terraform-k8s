variable "assets_bucket_name" {
  default = "cats-assets"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "environment" {
  default = "stg"
  type    = string
}