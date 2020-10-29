data "ibm_is_image" "iac_image" {
  name = var.image_name
}

resource "ibm_is_instance" "iac_test_instance" {
  name    = "${var.project_name}-${var.environment}-instance"
  resource_group  = data.ibm_resource_group.group.id
  image   = data.ibm_is_image.iac_image.id
  profile = var.profile

  primary_network_interface {
    name            = "eth0"
    subnet          = ibm_is_subnet.iac_test_subnet.id
    security_groups = [ibm_is_security_group.iac_test_security_group.id]
  }

  vpc  = ibm_is_vpc.iac_test_vpc.id
  zone = var.zone
  keys = [ data.ibm_is_ssh_key.iac_test_key.id, ibm_is_ssh_key.public_key.id ]

  user_data = file("${path.module}/scripts/setup.sh")

  tags = ["iac-${var.project_name}-${var.environment}"]
}

resource null_resource "wait-4-cloudinit" {

  depends_on = [ ibm_is_instance.iac_test_instance ]
  
  provisioner "remote-exec" {
    inline = [ "while [ ! -f '/root/cloudinit.done' ]; do echo 'waiting for userdata to complete...'; sleep 10; done" ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = ibm_is_floating_ip.iac_test_floating_ip.address
      private_key = tls_private_key.ssh_key_keypair.private_key_pem
    }
  }
}