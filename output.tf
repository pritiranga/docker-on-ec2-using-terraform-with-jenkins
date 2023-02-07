// Output
output "public_ip" {
  value = aws_instance.staging.public_ip
}

output "private_pem" {
  value = nonsensitive(tls_private_key.key.private_key_pem)
}

