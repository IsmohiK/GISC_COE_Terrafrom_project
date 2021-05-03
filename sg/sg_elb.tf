resource "aws_security_group" "elb_sg" {
  name        = "loadbalancer sg"
  description = "Allow SSH  inbound traffic"
  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "HTTP and HTTPS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["103.240.131.11/32", "103.240.131.50/32"]
}


  ingress {
    description = "HTTP and HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["103.240.131.11/32", "103.240.131.50/32"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
