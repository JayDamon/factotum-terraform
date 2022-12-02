resource "aws_s3_bucket" "jaydamon_s3_bucket" {
  bucket = var.domain_name
  tags = var.tags
}

resource "aws_s3_bucket_acl" "jaydamon_bucket_acl" {
  bucket = aws_s3_bucket.jaydamon_s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "jaydamon_s3_bucket_policy" {

  bucket = aws_s3_bucket.jaydamon_s3_bucket.id
  policy = <<EOF
    {
      "Version":"2008-10-17",
      "Statement":[{
        "Sid":"AllowPublicRead",
        "Effect":"Allow",
        "Principal": {"AWS": "*"},
        "Action":["s3:GetObject"],
        "Resource":["arn:aws:s3:::${var.domain_name}/*"]
      }]
    }
  EOF
}

resource "aws_s3_bucket_versioning" "jaydamo_s3_bucket_versioning" {
  bucket = aws_s3_bucket.jaydamon_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "jaydamon_s3_bucket_acl" {
  bucket = aws_s3_bucket.jaydamon_s3_bucket.id
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "jaydamon_s3_bucket_web_configuration" {

  depends_on = [aws_s3_bucket.jaydamon_s3_bucket]

  bucket = aws_s3_bucket.jaydamon_s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}