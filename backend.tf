resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "ia-automatizacion-jose-manuel-bucket"
    key            = "./terraform/terraform.tfstate"  # Ruta del estado dentro del bucket
    region         = "us-east-1"                  # Región del bucket
    use_lockfile = true
    encrypt        = true                         # Cifrado de datos en S3
  }
}

