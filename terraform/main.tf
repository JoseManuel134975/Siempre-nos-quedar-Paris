terraform {
  required_version = ">= 0.11.0"

  backend "s3" {
    bucket         = "ia-automatizacion-jose-manuel-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}