resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.environment}-curso-terraform-14112025"

  tags = {
    Name        = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Pierre Santos"
    UpdatedAt   = "2025-11-14"
  }
}