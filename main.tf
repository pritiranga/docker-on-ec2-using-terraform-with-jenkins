// Key pair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = var.key
  public_key = tls_private_key.key.public_key_openssh
}

//Security Group
resource "aws_security_group" "sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "test" {
  template = <<EOF
    mkdir /testing/test
  EOF
}

// EC2
resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
#   iam_instance_profile   = aws_iam_instance_profile.profile.name
  key_name               = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  #user_data       = filebase64("./user_data.sh")
  user_data = "$${data.template_file.test.rendered)}"
}



