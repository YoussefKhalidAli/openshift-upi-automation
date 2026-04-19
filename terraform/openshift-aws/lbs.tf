#################################
# OPENSHIFT API NLB
#################################

resource "aws_lb" "openshift_api" {
  name               = "openshift-api"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.main.id]
}

# 6443 - API (masters + bootstrap)
resource "aws_lb_target_group" "api_6443" {
  name     = "api-6443"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

# 22623 - bootstrap ignition
resource "aws_lb_target_group" "api_22623" {
  name     = "api-22623"
  port     = 22623
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "api_6443" {
  load_balancer_arn = aws_lb.openshift_api.arn
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_6443.arn
  }
}

resource "aws_lb_listener" "api_22623" {
  load_balancer_arn = aws_lb.openshift_api.arn
  port              = 22623
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_22623.arn
  }
}

#################################
# OPENSHIFT INGRESS NLB
#################################

resource "aws_lb" "openshift_ingress" {
  name               = "openshift-ingress"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.main.id]
}

resource "aws_lb_target_group" "ingress_80" {
  name     = "ingress-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "ingress_443" {
  name     = "ingress-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "ingress_80" {
  load_balancer_arn = aws_lb.openshift_ingress.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_80.arn
  }
}

resource "aws_lb_listener" "ingress_443" {
  load_balancer_arn = aws_lb.openshift_ingress.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_443.arn
  }
}