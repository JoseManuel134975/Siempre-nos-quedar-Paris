terraform {
  backend "s3" {
    bucket         = "ia-automatizacion-jose-manuel-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}