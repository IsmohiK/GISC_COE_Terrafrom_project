
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name =data.terraform_remote_state.asg.outputs.asg
#  elb=aws_elb.lb.id
  alb_target_group_arn   = aws_lb_target_group.alb-target.arn
}
