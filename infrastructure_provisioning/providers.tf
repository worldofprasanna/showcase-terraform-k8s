provider "aws" {
  region  = "us-west-2"
  version = ">= 2.38.0"
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

provider "http" {}