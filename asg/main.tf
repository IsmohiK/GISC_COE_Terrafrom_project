resource "aws_launch_template" "aws-LT" {
  name_prefix   = "launch_template"
  image_id = var.instance_image
  instance_type = var.ins_type
  key_name = "terraform-N.Virginia"
  iam_instance_profile {
    name = "SSMRole"
  }
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_id]
   tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }
  
  user_data = filebase64("userdata.sh")

}

resource "aws_autoscaling_group" "aws-asg" {
  vpc_zone_identifier       = [data.terraform_remote_state.networking.outputs.pri_sub_id]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_template {
    id      = aws_launch_template.aws-LT.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "test1"
    propagate_at_launch = true
  }

  
# provisioner "local-exec" {
#    command = "ansible-playbook -u ec2-user -i ec2.py --limit tag_Name_test1 --private-key ./pri-key.pem /terraform-ansible/ansible-playbook-httpd.yaml"
#  }


}

#resource "null_resource" "sshprivate" {
#depends_on = [aws_autoscaling_group.aws-asg]
# provisioner "local-exec" {
#    command = "ansible-playbook -u ec2-user -i ec2.py --limit tag_Name_test1 --private-key ./pri-key.pem /terraform-ansible/ansible-playbook-httpd.yaml"
#  }
#}


