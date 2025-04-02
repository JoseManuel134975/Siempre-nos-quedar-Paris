terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.bucket.bucket
    key            = "./terraform/terraform.tfstate"  # Ruta del estado dentro del bucket
    region         = "us-east-1"                  # Región del bucket
    dynamodb_table = "terraform-lock"             # Nombre de la tabla DynamoDB (solo si usas DynamoDB)
    encrypt        = true                         # Cifrado de datos en S3
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
