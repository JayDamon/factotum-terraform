data "aws_route53_zone" "factotum_software_zone" {
  name         = var.zone_name
  private_zone = false
}

resource "aws_route53_record" "jaydamon_route_53_record" {
  depends_on = [
    data.aws_route53_zone.factotum_software_zone,
    aws_cloudfront_distribution.jaydamon_s3_distribution
  ]

  zone_id = data.aws_route53_zone.factotum_software_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.jaydamon_s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.jaydamon_s3_distribution.hosted_zone_id
  }
}