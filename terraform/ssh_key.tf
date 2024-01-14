resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = var.private_key_path
}

resource "local_file" "public_key_file" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = var.public_key_path
}