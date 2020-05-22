provider "ibm" {
  # this code does not create non-iaas-classic resources
  # ibmcloud_api_key      = var.ibmcloud_api_key
  generation            = 1
  region                = var.region
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}

