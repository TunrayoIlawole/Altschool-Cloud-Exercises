variable "domain_name" {
  default = "motunrayoilawole.live"
  type = string
  description = "My domain name"
}

#Get hosted zone detail
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name

  tags = {
    Environment = "dev"
  }
}

# Create a record set in route53 
resource "aws_route53_record" "my_site_domain" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name = "terraform-test.${var.domain_name}"
  type = "A"

  alias {
    name = aws_lb.altschool-11-load-balancer.dns_name
    zone_id = aws_lb.altschool-11-load-balancer.zone_id
    evaluate_target_health = true
  }
}