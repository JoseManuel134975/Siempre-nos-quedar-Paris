resource "aws_s3_bucket" "bucket" {
  bucket        = "ia-automatizacion-jose-manuel-bucket-dynamo"
  force_destroy = true

  tags = {
    Name = var.name
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [ aws_s3_bucket_public_access_block.bucket_public_access_block ]

  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:PutBucketPolicy",
          "s3:ListBucket"
        ]
        Resource  = [ 
          aws_s3_bucket.bucket.arn
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "bucket_policy_objects" {
  depends_on = [ aws_s3_bucket_public_access_block.bucket_public_access_block ]

  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource  = [ 
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "bucket_website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}

data "local_file" "web_files" {
  for_each = fileset("../src", "**")            
  filename = "${abspath("../src")}/${each.key}"
}

resource "aws_s3_object" "object-upload" {
  for_each = data.local_file.web_files
  bucket   = aws_s3_bucket.bucket.id
  key      = each.key
  source   = each.value.filename
  content_type = lookup({
    "html" = "text/html"
    "css"  = "text/css"
    "png"   = "image/png",
    "gif"   = "image/gif",
    "svg"   = "image/svg+xml"
    "webp"  = "image/webp"
  }, regex("^.*\\.([a-z]+)$", each.key)[0], "application/octet-stream")
}


# resource "aws_s3_object" "object-upload-js" {
#   for_each = fileset("./web/src", "*.js")
#   bucket = aws_s3_bucket.bucket.id
#   key = each.value
#   source = "./web/src/${each.value}"
#   etag = filemd5("./web/src/${each.value}")
#   content_type = "application/javascript"
# }

# resource "aws_s3_object" "object-upload-css" {
#   for_each = fileset("./web/src", "*.css")
#   bucket = aws_s3_bucket.bucket.id
#   key = each.value
#   source = "./web/src/${each.value}"
#   etag = filemd5("./web/src/${each.value}")
#   content_type = "text/css"
# }

# resource "aws_s3_object" "object-upload-jpg" {
#   for_each = fileset("./web/src", "*.jpg")
#   bucket = aws_s3_bucket.bucket.id
#   key = each.value
#   source = "./web/src/${each.value}"
#   etag = filemd5("./web/src/${each.value}")
#   content_type = "image/jpg"
# }

# resource "aws_s3_object" "object-upload-jpeg" {
#   for_each = fileset("./web/src", "*.jpeg")
#   bucket = aws_s3_bucket.bucket.id
#   key = each.value
#   source = "./web/src/${each.value}"
#   etag = filemd5("./web/src/${each.value}")
#   content_type = "image/jpeg"
# }


# resource "aws_s3_object" "object-upload-png" {
#   for_each = fileset("./web/src", "*.png")
#   bucket = aws_s3_bucket.bucket.id
#   key = each.value
#   source = "./web/src/${each.value}"
#   etag = filemd5("./web/src/${each.value}")
#   content_type = "image/png"
# }