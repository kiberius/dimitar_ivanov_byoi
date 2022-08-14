#### LB ####
resource "aws_lb" "main" {
  name               = "LB-sandbox"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = data.aws_subnet_ids.lb.ids
  tags = {
    Name        = "LB-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

#### LISTENERS ####

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn

  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.web_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule-http-sandbox" {
  listener_arn = aws_lb_listener.http.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule-https-sandbox" {
  listener_arn = aws_lb_listener.https.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

#### TARGET GROUP ####
resource "aws_lb_target_group" "main" {
  name                          = "LB-Target-Group-sandbox"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = data.aws_vpc.main.id
  load_balancing_algorithm_type = "least_outstanding_requests"
  tags = {
    Name        = "ALB Target Group-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
  health_check {
    path                = "/"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 10
    matcher             = "200"
  }
}

#### Route53 and Certificate ####
data "aws_route53_zone" "site_dns_zone" {
  name         = "dimitar-ivanov-dex.com"
  private_zone = false
}

resource "aws_route53_record" "site_dns" {
  name    = "dimitar-ivanov-dex.com"
  type    = "A"
  zone_id = data.aws_route53_zone.site_dns_zone.id
  alias {
    evaluate_target_health = false
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
  }
}

resource "aws_acm_certificate" "web_cert" {
  domain_name       = "dimitar-ivanov-dex.com"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "web_cert_validation" {
  certificate_arn = aws_acm_certificate.web_cert.arn
}

resource "aws_lb_listener_certificate" "lb_listener_cert" {
  certificate_arn = aws_acm_certificate.web_cert.arn
  listener_arn    = aws_lb_listener.https.arn
}

#### WWW ####
resource "aws_route53_record" "www" {
  name    = "www"
  type    = "A"
  zone_id = data.aws_route53_zone.site_dns_zone.id
  alias {
    evaluate_target_health = false
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
  }
}

resource "aws_acm_certificate" "www_web_cert" {
  domain_name       = "dimitar-ivanov-dex.com"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "www_web_cert_validation" {
  certificate_arn = aws_acm_certificate.web_cert.arn
}

resource "aws_lb_listener_certificate" "www_lb_listener_cert" {
  certificate_arn = aws_acm_certificate.web_cert.arn
  listener_arn    = aws_lb_listener.https.arn
}