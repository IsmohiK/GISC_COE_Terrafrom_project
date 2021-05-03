data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket         = "dev-gisc-terraform-remote-backend-state"
    key            = "dev/vpc.tfstate"
    dynamodb_table = "gisc_terraform_remote_backend_state_lock_dev"
    region = "us-east-1"
  }
}
