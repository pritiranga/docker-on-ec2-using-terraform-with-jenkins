variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0b93ce03dcbcb10f6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key" {
  default = "t-docker"
}

variable "bucket-name" {
  default = "terraform-jenkins-local"
}

variable "terra-vpc" {
  default = "vpc-0a67cd391f2db0d7f"
}

variable "terra-subnet" {
  default = "subnet-080049d7314f2cecd"
}

variable "terra-sg" {
  default = "sg-0a39a1a0c4fd89877"
}