resource "aws_cloudfront_distribution" "jaydamon_s3_distribution" {

  depends_on = [
    aws_s3_bucket_website_configuration.jaydamon_s3_bucket_web_configuration,
    aws_acm_certificate.jaydamon_certificate
  ]

  origin {
    origin_id                = var.domain_name
    domain_name              = format("%s.s3.amazonaws.com", var.domain_name)
  }

  aliases = [var.domain_name]

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.domain_name

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.jaydamon_certificate.arn
    ssl_support_method = "sni-only"
  }

  tags = var.tags
}