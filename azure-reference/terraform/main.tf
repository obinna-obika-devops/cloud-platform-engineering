terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" { features {} }

resource "azurerm_resource_group" "platform" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  prefix              = var.prefix
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  prefix              = var.prefix
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  prefix              = var.prefix
}

module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  prefix              = var.prefix
}

module "aks" {
  source                       = "./modules/aks"
  resource_group_name          = azurerm_resource_group.platform.name
  location                     = azurerm_resource_group.platform.location
  prefix                       = var.prefix
  subnet_id                    = module.network.aks_subnet_id
  log_analytics_workspace_id   = module.monitoring.workspace_id
}
