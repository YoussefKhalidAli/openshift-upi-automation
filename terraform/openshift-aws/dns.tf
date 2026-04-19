#################################
# Node DNS records
#################################

resource "aws_route53_record" "bootstrap" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "bootstrap.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.114"]
}

resource "aws_route53_record" "master0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "control-plane0.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.71"]
}

resource "aws_route53_record" "master1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "control-plane1.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.163"]
}

resource "aws_route53_record" "master2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "control-plane2.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.205"]
}

resource "aws_route53_record" "worker0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker0.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.18"]
}

resource "aws_route53_record" "worker1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker1.mycluster.openshift.net."
  type    = "A"
  ttl     = 300
  records = ["10.0.1.65"]
}

#################################
# PTR Records (Reverse DNS)
#################################

resource "aws_route53_record" "ptr_bootstrap" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "114"
  type    = "PTR"
  ttl     = 60
  records = ["bootstrap.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_master0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "71"
  type    = "PTR"
  ttl     = 60
  records = ["control-plane0.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_master1" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "163"
  type    = "PTR"
  ttl     = 60
  records = ["control-plane1.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_master2" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "205"
  type    = "PTR"
  ttl     = 60
  records = ["control-plane2.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_worker0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "18"
  type    = "PTR"
  ttl     = 60
  records = ["worker0.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_worker1" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "65"
  type    = "PTR"
  ttl     = 60
  records = ["worker1.mycluster.openshift.net."]
}

#################################
# API DNS
#################################

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.mycluster.openshift.net."
  type    = "A"

  alias {
    name                   = aws_lb.openshift_api.dns_name
    zone_id                = aws_lb.openshift_api.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api_int" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api-int.mycluster.openshift.net."
  type    = "A"

  alias {
    name                   = aws_lb.openshift_api.dns_name
    zone_id                = aws_lb.openshift_api.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api_net" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api-net.mycluster.openshift.net."
  type    = "A"

  alias {
    name                   = aws_lb.openshift_api.dns_name
    zone_id                = aws_lb.openshift_api.zone_id
    evaluate_target_health = true
  }
}

#################################
# Ingress wildcard
#################################

resource "aws_route53_record" "apps" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "*.apps.mycluster.openshift.net."
  type    = "A"

  alias {
    name                   = aws_lb.openshift_ingress.dns_name
    zone_id                = aws_lb.openshift_ingress.zone_id
    evaluate_target_health = true
  }
}