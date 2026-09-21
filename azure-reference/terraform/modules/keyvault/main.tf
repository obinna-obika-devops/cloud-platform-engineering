data "azurerm_client_config" "current" {}

variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "prefix" { type = string }

resource "azurerm_key_vault" "this" {
  name                       = substr("${var.prefix}-kv", 0, 24)
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = true
}

output "name" { value = azurerm_key_vault.this.name }
