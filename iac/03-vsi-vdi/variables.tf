variable "project_name" {}
variable "environment" {}

variable "ssh_keyname" {
  default = ""
}

# default to using CentOS 8
variable "image_name" {
  default = "ibm-centos-8-2-minimal-amd64-1"
}

variable "profile" {
  default = "cx2-2x4"
}

# the IBM Cloud resource group to use for vms that are created
variable "resource_group" {
  default = "Default"
}

# the VPC zone to use for the vm
variable "zone" {
  default = "us-south-1"
}

# the IBM Cloud region to use (note: this must be a VPC-enabled region)
variable "region" {
  default = "us-south"
}