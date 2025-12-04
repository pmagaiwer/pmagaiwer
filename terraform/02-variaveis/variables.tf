variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
}

variable "instance_ami" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  type        = string
}

variable "instance_tags" {
  description = "The instance type to use for the instance"
  type        = map(string)
  default     = {
    Name = "Ubuntu"
    Project = "Curso AWS com Terraform"
  }
}