
 # get hosted zone details
resource "aws_route53_zone" "project-hosted-zone" {
  name = var.domain_names.domain_name

  tags = {
    Environment = "dev"
  }
}

# awsRoute53Record
resource "aws_route53_record" "project-subdomain" {
  zone_id = aws_route53_zone.project-hosted-zone.zone_id
  name    = var.domain_names.subdomain_name
  type    = "A"
  ttl     = "300"

#   alias {
#   #   name                   = a0f96cefe03de4503a322df92350084f-129464669.eu-west-2.elb.amazonaws.com.dns_name
#   #   zone_id                = a0f96cefe03de4503a322df92350084f-129464669.eu-west-2.elb.amazonaws.com.zone_id
#     evaluate_target_health = true
#   }
}

resource "namedotcom_domain_nameservers" "domain_name" {
  domain_name = var.domain_names.domain_name
  nameservers = [
    aws_route53_zone.project-hosted-zone.name_servers[0],
    aws_route53_zone.project-hosted-zone.name_servers[1],
    aws_route53_zone.project-hosted-zone.name_servers[2],
    aws_route53_zone.project-hosted-zone.name_servers[3],
  ]
}

data "aws_route53_zone" "sock-domain" {
  name = var.domain_names.domain_name
}

# resource "aws_route53_zone" "sock-domain" {
#   name    =  var.domain_names.domain_name
#   comment = "My domain name"
# }


resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email_address
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = data.aws_route53_zone.sock-domain.name
  subject_alternative_names = ["*.${data.aws_route53_zone.sock-domain.name}"]

  dns_challenge {
    provider = "route53"

    config = {
      AWS_HOSTED_ZONE_ID = data.aws_route53_zone.sock-domain.zone_id
    }
  }

  depends_on = [acme_registration.registration]
}

resource "aws_acm_certificate" "certificate" {
  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem
}