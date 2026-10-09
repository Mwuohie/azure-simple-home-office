terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_windows_virtual_machine" "home_office_windows_vm" {
  name                  = "home-offwin-vm"
  computer_name         = "home-offwin-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  admin_password        = var.admin_password
  network_interface_ids = [var.network_interface_ids[0]]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "home_office_linux_vm" {
  name                            = "home-office-linux-vm"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = [var.network_interface_ids[1]]
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
}
