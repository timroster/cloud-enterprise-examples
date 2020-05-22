# uncomment this entry to use a previously uploaded classic ssh key
# 
# data "ibm_compute_ssh_key" "public_ssh_key" {
#  label = var.key_name
#}

resource "ibm_compute_ssh_key" "public_ssh_key" {
    label = format("${lower(var.instance_name)}-ssh-key")
    public_key = var.public_key
}

resource "ibm_compute_vm_instance" "master" {
  count = var.master["nodes"]

  datacenter = var.datacenter
  domain     = var.domain
  hostname   = format("${lower(var.instance_name)}-master%01d", count.index + 1)

  os_reference_code = "UBUNTU_18_64"

  cores  = var.master["cpu_cores"]
  memory = var.master["memory"]

  disks                = [ var.master["boot_size"], var.master["opt_disk"] ]
  local_disk           = var.master["local_disk"]
  network_speed        = var.master["network_speed"]
  hourly_billing       = var.master["hourly_billing"]
  private_network_only = var.master["private_network_only"]
  public_vlan_id       = var.public_vlan_id
  private_vlan_id      = var.private_vlan_id

  user_metadata = file("${path.module}/scripts/master.sh")

  ssh_key_ids = [ibm_compute_ssh_key.public_ssh_key.id]
  # ssh_key_ids = [data.ibm_compute_ssh_key.public_ssh_key.id]
}

resource "ibm_compute_vm_instance" "slave" {
  count = var.slave["nodes"]

  datacenter = var.datacenter
  domain     = var.domain
  hostname   = format("${lower(var.instance_name)}-slave%01d", count.index + 1)

  os_reference_code = "UBUNTU_18_64"

  cores  = var.slave["cpu_cores"]
  memory = var.slave["memory"]

  disks                = [ var.slave["boot_size"], var.slave["opt_disk"] ]
  local_disk           = var.slave["local_disk"]
  network_speed        = var.slave["network_speed"]
  hourly_billing       = var.slave["hourly_billing"]
  private_network_only = var.slave["private_network_only"]
  public_vlan_id       = var.public_vlan_id
  private_vlan_id      = var.private_vlan_id

  user_metadata = file("${path.module}/scripts/slave.sh")

  ssh_key_ids = [ibm_compute_ssh_key.public_ssh_key.id]
  # ssh_key_ids = [data.ibm_compute_ssh_key.public_ssh_key.id]
}

output "master_ip_address" {
  value = ibm_compute_vm_instance.master[*].ipv4_address
}

output "slave_ip_address" {
  value = ibm_compute_vm_instance.slave[*].ipv4_address
}