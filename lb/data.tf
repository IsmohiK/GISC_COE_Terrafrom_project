


data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/sg.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}




data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/vpc.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "local"

  config = {
    path = "/terraform-ansible/ec2/terraform.tfstate"
  }
}
#aws_autoscaling_group.aws-asg
data "terraform_remote_state" "asg" {
   backend = "s3"

  config = {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/asg.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}
