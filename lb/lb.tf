resource "aws_elb" "lb" {
  name = var.name
  security_groups=[data.terraform_remote_state.sg.outputs.sg_elb_id]
  subnets=[data.terraform_remote_state.networking.outputs.pub_sub_id]

  listener {
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol 
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
#  instances                   =[data.terraform_remote_state.ec2.outputs.instance_id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.tag_name
  }
}
