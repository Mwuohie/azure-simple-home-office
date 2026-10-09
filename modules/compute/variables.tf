variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "network_interface_ids" {
  description = "Network interface IDs for the Windows and Linux VMs, respectively"
  type        = list(string)
}

variable "admin_password" {
  description = "Admin password for the VMs"
  type        = string
  sensitive   = true
}
