variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "vnet_address_space" {
  description = "The address space to use for the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "The prefixes to use for the subnets in the virtual network."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}