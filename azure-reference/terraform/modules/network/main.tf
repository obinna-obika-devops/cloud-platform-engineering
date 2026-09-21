variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "prefix" { type = string }

resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.20.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.20.1.0/24"]
}

output "aks_subnet_id" { value = azurerm_subnet.aks.id }
