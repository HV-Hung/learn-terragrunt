// remote_state {
//   backend = "local"
//   generate = {
//     path    ="backend.tf"
//     if_exists = "overwrite_terragrunt"
//   } 
//   config = {
//     path = "${path_relative_to_include()}/terraform.tfstate"
//   }
    
// }

terraform {
 after_hook "echo"{
    commands = ["fmt"]
    execute = ["echo", "relatvie path: ${path_relative_to_include()}"]
 }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<FOF
    provider "azurerm" {
        features {}
    }
    FOF
}
generate "backend" {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<FOF
    terraform {
        backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate1782876454"
        container_name       = "tfstate"
        key                  = "${path_relative_to_include()}/terraform.tfstate"
        }
    }

    FOF
}

