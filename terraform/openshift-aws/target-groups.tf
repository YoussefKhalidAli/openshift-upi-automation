resource "aws_lb_target_group_attachment" "masters_6443" {
  for_each = {
    "master0" = aws_instance.nodes["openshift-master0"].id
    "infra0" = aws_instance.nodes["openshift-infra0"].id
  }

  target_group_arn = aws_lb_target_group.api_6443.arn
  target_id        = each.value
  port             = 6443
}

resource "aws_lb_target_group_attachment" "config_22623" {
  for_each = {
    "master0" = aws_instance.nodes["openshift-master0"].id
    "infra0" = aws_instance.nodes["openshift-infra0"].id
  }
  
  target_group_arn = aws_lb_target_group.api_22623.arn
  target_id        = each.value
  port             = 22623
}

resource "aws_lb_target_group_attachment" "compute_80" {
  for_each = {
    "infra0" = aws_instance.nodes["openshift-infra0"].id
    "odf0" = aws_instance.nodes["openshift-odf0"].id
    "worker0" = aws_instance.nodes["openshift-worker0"].id
    "worker1" = aws_instance.nodes["openshift-worker1"].id
    "worker2" = aws_instance.nodes["openshift-worker2"].id
    "worker3" = aws_instance.nodes["openshift-worker3"].id
  }

  target_group_arn = aws_lb_target_group.ingress_80.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_target_group_attachment" "compute_443" {
  for_each = {
    "infra0" = aws_instance.nodes["openshift-infra0"].id
    "odf0" = aws_instance.nodes["openshift-odf0"].id
    "worker0" = aws_instance.nodes["openshift-worker0"].id
    "worker1" = aws_instance.nodes["openshift-worker1"].id
    "worker2" = aws_instance.nodes["openshift-worker2"].id
    "worker3" = aws_instance.nodes["openshift-worker3"].id
  }

  target_group_arn = aws_lb_target_group.ingress_443.arn
  target_id        = each.value
  port             = 443
}