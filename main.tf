// Key pair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.default.key_name}.pem"
  content = tls_private_key.key.private_key_pem
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
resource "aws_instance" "staging" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  sensitive = true

  tags = {
    Name = "Staging-docker"
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.key.private_key_pem
    host        = self.public_ip
  }
  
  provisioner "file" {
    source      = "user_data.sh"
    destination = "/home/ubuntu/user_data.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/user_data.sh",
      "sudo /home/ubuntu/user_data.sh"
    ]
  }
}




