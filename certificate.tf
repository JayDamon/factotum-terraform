resource "aws_acm_certificate" "jaydamon_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_route53_record" "jaydamon_certificate_validation_record" {

  depends_on = [aws_acm_certificate.jaydamon_certificate]

  for_each = {
  for dvo in aws_acm_certificate.jaydamon_certificate.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.factotum_software_zone.zone_id

}

resource "aws_acm_certificate_validation" "jaydamon_acm_cert_validation" {
  certificate_arn         = aws_acm_certificate.jaydamon_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.jaydamon_certificate_validation_record : record.fqdn]
}