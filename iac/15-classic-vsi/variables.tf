##### common VM specifications ######
variable "region" {
  default = ""
}

variable "datacenter" {
  default = ""
}

variable "public_vlan_id" {
  default = ""
}

variable "private_vlan_id" {
  default = ""
}

variable "domain" {
  default = "ihost.com"
}

# VM basename
variable "instance_name" {
  default = "demo"
}

##### Master Instance details ######
variable "master" {
  type = map(string)
  default = {
    nodes                = "1"
    cpu_cores            = "8"
    boot_size            = "100" // GB
    opt_disk             = "200"
    local_disk           = false
    memory               = "32768"
    network_speed        = "1000"
    private_network_only = false
    hourly_billing       = true
  }
}

##### Slave Instance details ######
variable "slave" {
  type = map(string)
  default = {
    nodes                = "1"
    cpu_cores            = "8"
    boot_size            = "100" // GB
    opt_disk             = "50"
    local_disk           = false
    memory               = "32768"
    network_speed        = "1000"
    private_network_only = false
    hourly_billing       = true
  }
}
