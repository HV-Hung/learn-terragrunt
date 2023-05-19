# environments/dev/terragrunt.hcl

terraform {
 source = "../modules/vm"
}

include "root" {
  path = find_in_parent_folders()
}
dependency "vnet" {
  config_path ="../vnet"
  
}

dependencies {
  paths = ["../vnet"]
}

# Module configuration
inputs = {
  resource_group_location = "West US"
  resource_group_name = "tg-vnet"
  subnet_id = dependency.vnet.outputs.subnet_id
  nsg_id  = dependency.vnet.outputs.nsg_id
  vm_name = "vm"
}
