terraform {
  backend "s3" {
    bucket         = "tristy-app"
    key            = "instance-scheduler/terraform.tfstate-dev"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
