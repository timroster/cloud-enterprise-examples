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
    cpu_cores            = "1"
    boot_size            = "25" // GB
    opt_disk             = "25"
    local_disk           = false
    memory               = "2048"
    network_speed        = "100"
    private_network_only = false
    hourly_billing       = true
  }
}

##### Slave Instance details ######
variable "slave" {
  type = map(string)
  default = {
    nodes                = "1"
    cpu_cores            = "1"
    boot_size            = "25" // GB
    opt_disk             = "25"
    local_disk           = false
    memory               = "2048"
    network_speed        = "100"
    private_network_only = false
    hourly_billing       = true
  }
}

# uncomment this entry to use a previously uploaded classic ssh key
#
#variable "key_name" {
#  description = "Name or reference of SSH key to provision softlayer instances with"
#  default     = "timrosl_ssh_key"
#}

# Variable for adding a new classic ssh key given an input value
variable "public_key" {}
