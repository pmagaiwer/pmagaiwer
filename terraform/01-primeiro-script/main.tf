terraform {
  required_version = ">= 0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf014"
}

# Create a S3 bucket
resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-25021988100920142025"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Pierre Santos"
    UpdatedAt   = "2024-02-19"
  }
}