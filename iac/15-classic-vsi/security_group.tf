# Security filters for hosts three groups will be applied to public interfaces
# IBM provides two rules: "allow_outbound" - permits all egress, and "allow_ssh" -
# permits ssh ingress. An additional security group example is shown with rules
# allowing inbound traffic to tcp port 8080 over IPv4/IPv6

data "ibm_security_group" "allow_ssh" {
  name = "allow_ssh"
}

data "ibm_security_group" "allow_outbound" {
  name = "allow_outbound"
}

resource "ibm_security_group" "custom_sg" {
    name = format("${lower(var.instance_name)}-sg")
}

resource "ibm_security_group_rule" "allow_8080_v4" {
    direction = "ingress"
    ether_type = "IPv4"
    port_range_min = 8080
    port_range_max = 8080
    # uncomment and set to restrict traffic to specific source/destination IP or CIDR
    # remote_ip = 192.168.100.0/24
    protocol = "tcp"
    security_group_id = ibm_security_group.custom_sg.id
}

resource "ibm_security_group_rule" "allow_8080_v6" {
    direction = "ingress"
    ether_type = "IPv6"
    port_range_min = 8080
    port_range_max = 8080
    # uncomment and set to restrict traffic to specific source/destination IP or CIDR
    # remote_ip = 192.168.100.0/24
    protocol = "tcp"
    security_group_id = ibm_security_group.custom_sg.id
}

# Associate security groups to master and slave node interfaces

resource "ibm_network_interface_sg_attachment" "master-sg-ssh" {
    security_group_id = data.ibm_security_group.allow_ssh.id
    network_interface_id = ibm_compute_vm_instance.master[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.master["nodes"]
}

resource "ibm_network_interface_sg_attachment" "master-sg-out" {
    security_group_id = data.ibm_security_group.allow_outbound.id
    network_interface_id = ibm_compute_vm_instance.master[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.master["nodes"]
}

resource "ibm_network_interface_sg_attachment" "master-sg-custom" {
    security_group_id = ibm_security_group.custom_sg.id
    network_interface_id = ibm_compute_vm_instance.master[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.master["nodes"]
}

resource "ibm_network_interface_sg_attachment" "slave-sg-ssh" {
    security_group_id = data.ibm_security_group.allow_ssh.id
    network_interface_id = ibm_compute_vm_instance.slave[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.slave["nodes"]
}

resource "ibm_network_interface_sg_attachment" "slave-sg-out" {
    security_group_id = data.ibm_security_group.allow_outbound.id
    network_interface_id = ibm_compute_vm_instance.slave[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.slave["nodes"]
}

resource "ibm_network_interface_sg_attachment" "slave-sg-custom" {
    security_group_id = ibm_security_group.custom_sg.id
    network_interface_id = ibm_compute_vm_instance.slave[count.index].public_interface_id
    soft_reboot = "false"
    //User can increase timeouts 
    timeouts {
      create = "15m"
    }
    count = var.slave["nodes"]
}