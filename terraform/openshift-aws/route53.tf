#################################
# PRIVATE HOSTED ZONE
#################################

resource "aws_route53_zone" "main" {
  name = "mycluster.openshift.net"

  vpc {
    vpc_id = aws_vpc.main.id
  }

  comment = "OpenShift private zone"
}

resource "aws_route53_zone" "reverse_10" {
  name = "1.0.10.in-addr.arpa"

  vpc {
    vpc_id = aws_vpc.main.id
  }

  comment = "Reverse DNS for 10.0.1.0/24"
}
