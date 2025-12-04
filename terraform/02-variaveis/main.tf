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
  region  = var.aws_region
  profile = var.aws_profile
}

# Create a EC2 Instance
resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags          = var.instance_tags
}
