output "lc" {
  value = aws_launch_template.aws-LT.id
}


output "asg" {
  value = aws_autoscaling_group.aws-asg.id
}
