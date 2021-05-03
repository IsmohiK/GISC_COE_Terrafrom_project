provider "aws" {
region = "us-east-1"

}


#terraform {
#  backend "local" {
#    path = "/terraform-ansible/sg/sg.tfstate"
#  }
#}




terraform {
  backend "s3" {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/asg.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}
