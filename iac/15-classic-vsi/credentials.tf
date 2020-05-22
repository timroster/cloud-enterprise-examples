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
