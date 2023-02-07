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

// EC2
resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource null_resource name {
  # triggers = {
  #   trigger = value
  # }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/t-docker")
    host        = aws_instance.ec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y"

    ]
  }
}




