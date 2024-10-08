terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Stack     = "Fugro"
      Terraform = "true"
    }
  }
  region = "eu-west-1"
}