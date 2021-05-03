provider "aws" {
region = var.region

}


#terraform {
#  backend "local" {
#    path = "/terraform-ansible/vpc/vpc.tfstate"
#  }
#}

terraform {
  backend "s3" {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/vpc.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}
