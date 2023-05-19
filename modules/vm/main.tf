resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location
  allocation_method   = "Static" 
}
 

resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}
 
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/pingping.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name = var.vm_name
}

# Associate the security group with the VM network interfaces
resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  network_interface_id                = azurerm_network_interface.nic.id
  network_security_group_id           = var.nsg_id
}

