
resource "aws_security_group" "allow_ssh" {
  name        = "SG for new TF"
  description = "Allow SSH  inbound traffic"
  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "SSH from jenkins to private instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.18/32"]
}

  ingress {
    description = "Loadbalancer sg"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups=[aws_security_group.elb_sg.id]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
