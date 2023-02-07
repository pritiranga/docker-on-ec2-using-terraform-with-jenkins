terraform {
  backend "s3" {
    bucket = "terraform-jenkins-local"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}