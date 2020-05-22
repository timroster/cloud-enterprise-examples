# variables used by ibm terraform provider to authenticate
# populate using secrets.auto.tfvars files or values in schematics workspace json

# this code does not create non-iaas-classic resources
#variable "ibmcloud_api_key" {
#  default = ""
#}

variable "iaas_classic_username" {
  default = ""
}

variable "iaas_classic_api_key" {
  default = ""
}

# Variable for adding a new classic ssh key given an input value
variable "public_key" {
  default = ""
}

# uncomment this entry to use a previously uploaded classic ssh key
#
#variable "key_name" {
#  description = "Name or reference of SSH key to provision softlayer instances with"
#  default     = "my_ssh_key"
#}
