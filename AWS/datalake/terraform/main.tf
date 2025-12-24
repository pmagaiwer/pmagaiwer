
provider "aws" {
  region = "us-east-1"
}

module "s3_datalake" {
  source = "../modules/s3"
}
