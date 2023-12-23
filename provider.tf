terraform {

  backend "s3" {
    bucket         = "akilan-terraform-task"
    key            = "terraform-task"
    region         = "ap-south-1"
    dynamodb_table = "terraform-task-state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
