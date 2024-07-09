# Configure Terraform to use the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider for your specific usage
provider "aws" {
  region = "us-east-1"
}
