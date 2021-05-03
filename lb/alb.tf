#resource "aws-alb" "alb" {
# Name = "alb demo"
# security_groups=[data.terraform_remote_state.sg.outputs.sg_elb_id]
# subnets=[data.terraform_remote_state.networking.outputs.pub_sub_id]

#listener {
#   port               = 80
#   protocol           = "HTTP"
#}

#target_groups = [
#    {
#      name_prefix      = "target"
#      backend_protocol = "HTTP"
#      backend_port     = 80
#      target_type      = "instance"
#}
#]
#health_check {
#protocol="http"
#path="/"
#    healthy_threshold   = 5
#    unhealthy_threshold = 5
#    timeout             = 3
#    target              = "HTTP:80/"
 #   interval            = 30
 # }

#}


resource "aws_lb" "alb" {
  name               = "gisc-terraform-alb"
  security_groups=[data.terraform_remote_state.sg.outputs.sg_elb_id]
  load_balancer_type = "application"
  subnets            = [data.terraform_remote_state.networking.outputs.pub_sub_id,data.terraform_remote_state.networking.outputs.db_sub_id]

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn

  port              = 80
  protocol          = "HTTP"

#  ssl_policy        = "ELBSecurityPolicy-2016-08"
 # certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target.arn
  }
}

resource "aws_lb_target_group" "alb-target" {
  port     = 80
  protocol = "HTTP"
#  vpc_id   = var.vpc_id
vpc_id = data.terraform_remote_state.networking.outputs.vpc_id
  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
  }

  depends_on = [
    aws_lb.alb
  ]

  lifecycle {
    create_before_destroy = true
  }
}


