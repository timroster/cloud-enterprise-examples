provider "ibm" {
  generation = 2
  region     = var.region
}

data "ibm_is_ssh_key" "iac_test_key" {
  name       = var.ssh_keyname
}

# Create a ssh keypair which will be used to provision code onto the system - and also access the VM for debug if needed.
resource tls_private_key "ssh_key_keypair" {
  algorithm = "RSA"
  rsa_bits = "2048"
}

# Create an public/private ssh key pair to be used to login to VMs
resource ibm_is_ssh_key "public_key" {
  name = "${var.project_name}-${var.environment}-public-key"
  public_key = tls_private_key.ssh_key_keypair.public_key_openssh
}
