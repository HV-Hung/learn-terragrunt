# environments/dev/terragrunt.hcl

terraform {
 source = "../modules/network"
 after_hook "echo"{
    commands = ["fmt"]
    // execute = ["echo", "find in parent folder: ${find_in_parent_folders()}"]
    execute = ["echo", "relatvie path: ${path_relative_to_include()}"]
 }
}


include "root" {
  path = find_in_parent_folders()
}



# Module configuration
inputs = {
  resource_group_location = "West US"
  resource_group_name     = "tg-vnet"
  vnet_address_space      = "10.0.0.0/16"
  subnet_prefixes  = ["10.0.1.0/24"]
}
