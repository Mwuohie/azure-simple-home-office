terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "home_office_rg" {
  name     = "home-office-rg"
  location = "australiaeast"
}

module "network" {
  source              = "./modules/networking"
  resource_group_name = azurerm_resource_group.home_office_rg.name
  location            = azurerm_resource_group.home_office_rg.location
}

module "compute" {
  source                = "./modules/compute"
  resource_group_name   = azurerm_resource_group.home_office_rg.name
  location              = azurerm_resource_group.home_office_rg.location
  network_interface_ids = module.network.network_interface_ids
  admin_password        = var.admin_password
}
