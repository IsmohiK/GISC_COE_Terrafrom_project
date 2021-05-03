output "sg_id" {
  value = aws_security_group.allow_ssh.id
}


output "sg_elb_id" {
  value = aws_security_group.elb_sg.id
}
