output "resource_group_name" {
  value = azurerm_resource_group.platform.name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "key_vault_name" {
  value = module.keyvault.name
}
