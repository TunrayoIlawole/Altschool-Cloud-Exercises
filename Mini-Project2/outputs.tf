output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.altschool-11-target-group.arn
}

output "elb_load_balancer_dns_name" {
  value = aws_lb.altschool-11-load-balancer.dns_name
}

output "elastic_load_balancer_zone_id" {
  value = aws_lb.altschool-11-load-balancer.zone_id
}