provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}