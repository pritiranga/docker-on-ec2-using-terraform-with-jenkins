data "aws_vpc" "terra-vpc" {
  id = var.terra-vpc
}

data "aws_subnet" "terra-subnet" {
  id = var.terra-subnet
}

data "aws_security_group" "terra-sg" {
  id = var.terra-sg
}

resource "aws_instance" "Staging-Instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.terra-subnet.id
  vpc_security_group_ids      = [data.aws_security_group.terra-sg.id]
  key_name                    = var.key
  associate_public_ip_address = "true"

  tags = {
    "Name" = "Staging-Docker-Instance"
  }
}

# Provisioners for docker image
# Terraform is logging onto the EC2 to run the provisioner files
resource "null_resource" "key" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.Staging-Instance.public_ip
  }

  # File being copied to the server
  provisioner "file" {
    source      = "."
    destination = "/home/ubuntu/"
  }


}






