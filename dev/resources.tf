##terraform {
##  backend "s3" { 
##  }
##}

resource "aws_s3_bucket" "terraform_remote_backend_state" {
	bucket = "${var.s3_bucket_name}"
	lifecycle {
		prevent_destroy = true
	}
	versioning {
		enabled = true
	}
	server_side_encryption_configuration {
    	rule {
      		apply_server_side_encryption_by_default {
        		sse_algorithm = "AES256"
      		}
    	}
  	}
}

resource "aws_dynamodb_table" "terraform_remote_backend_state_lock" {
  name = "${var.dynamodb_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}

##resource "aws_instance" "EC2_instance" {
##  ami = "${var.ami-name}"
##  instance_type = "${var.instance_type}"
##  count="${var.desiredCapacity}"
##  tags = {
##    Name = "${var.name}"
##    Environment = "${var.environment}"
##  }
##}

##output "ime" {
##   value = ["${aws_instance.EC2_instance.*.public_ip}"]
##}

