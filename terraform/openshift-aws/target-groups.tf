resource "aws_lb_target_group_attachment" "masters_6443" {
  for_each = {
    "master0" = aws_instance.nodes["openshift-master0"].id
    "master1" = aws_instance.nodes["openshift-master1"].id
    "master2" = aws_instance.nodes["openshift-master2"].id
    "bootstrap" = aws_instance.nodes["openshift-bootstrap"].id
  }

  target_group_arn = aws_lb_target_group.api_6443.arn
  target_id        = each.value
  port             = 6443
}

resource "aws_lb_target_group_attachment" "bootstrap_22623" {
  target_group_arn = aws_lb_target_group.api_22623.arn
  target_id        = aws_instance.nodes["openshift-bootstrap"].id
  port             = 22623
}

resource "aws_lb_target_group_attachment" "workers_80" {
  for_each = {
    "worker0" = aws_instance.nodes["openshift-worker0"].id
    "worker1" = aws_instance.nodes["openshift-worker1"].id
  }

  target_group_arn = aws_lb_target_group.ingress_80.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_target_group_attachment" "workers_443" {
  for_each = {
    "worker0" = aws_instance.nodes["openshift-worker0"].id
    "worker1" = aws_instance.nodes["openshift-worker1"].id
  }

  target_group_arn = aws_lb_target_group.ingress_443.arn
  target_id        = each.value
  port             = 443
}