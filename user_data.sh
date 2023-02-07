#! /bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Make sure we have all the latest updates when we launch this instance
sudo apt update -y && sudo apt upgrade -y

# Install components
sudo apt install -y docker.io

# Add credential helper to pull from ECR
# mkdir -p ~/.docker && chmod 0700 ~/.docker
# echo '{"credsStore": "ecr-login"}' > ~/.docker/config.json

# Start docker now and enable auto start on boot
service docker start && chkconfig docker on

# Allow the ec2-user to run docker commands without sudo
sudo usermod -a -G docker ubuntu

