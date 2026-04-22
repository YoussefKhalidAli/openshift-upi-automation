#################################
# Node DNS records
#################################

resource "aws_route53_record" "bootstrap" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "bootstrap.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.100"]
}

resource "aws_route53_record" "master0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "control-plane0.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.101"]
}

resource "aws_route53_record" "infra0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "infra0.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.100"]
}

resource "aws_route53_record" "worker0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker0.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.200"]
}

resource "aws_route53_record" "worker1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker1.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.201"]
}

resource "aws_route53_record" "worker2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker2.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.202"]
}

resource "aws_route53_record" "worker3" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "worker3.mycluster.openshift.net."
  type    = "A"
  ttl     = 60
  records = ["10.0.1.203"]
}

resource "aws_route53_record" "odf0" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "odf0.mycluster.openshift.net."
  type    = "A"
  ttl     = 300
  records = ["10.0.1.222"]
}

#################################
# PTR Records (Reverse DNS)
#################################

resource "aws_route53_record" "ptr_infra0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "100"
  type    = "PTR"
  ttl     = 60
  records = ["infra0.mycluster.openshift.net."]
}


resource "aws_route53_record" "ptr_master0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "101"
  type    = "PTR"
  ttl     = 60
  records = ["control-plane0.mycluster.openshift.net."]
}


resource "aws_route53_record" "ptr_worker0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "200"
  type    = "PTR"
  ttl     = 60
  records = ["worker0.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_worker1" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "201"
  type    = "PTR"
  ttl     = 60
  records = ["worker1.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_worker2" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "202"
  type    = "PTR"
  ttl     = 60
  records = ["worker2.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_worker3" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "203"
  type    = "PTR"
  ttl     = 60
  records = ["worker3.mycluster.openshift.net."]
}

resource "aws_route53_record" "ptr_odf0" {
  zone_id = aws_route53_zone.reverse_10.zone_id
  name    = "222"
  type    = "PTR"
  ttl     = 60
  records = ["odf0.mycluster.openshift.net."]
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