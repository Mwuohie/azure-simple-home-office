terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_virtual_network" "home_office_vnet" {
  name                = "home-office-vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_subnet" "home_office_snet" {
  name                 = "home-office-snet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.home_office_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "home_office_nic" {
  count               = 2
  name                = "home-office-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.home_office_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}

output "network_interface_ids" {
  value = azurerm_network_interface.home_office_nic[*].id
}
