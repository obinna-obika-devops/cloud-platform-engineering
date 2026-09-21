variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "prefix" { type = string }
variable "subnet_id" { type = string }
variable "log_analytics_workspace_id" { type = string }

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name           = "system"
    vm_size        = "Standard_D2s_v5"
    vnet_subnet_id = var.subnet_id
    auto_scaling_enabled = true
    min_count      = 1
    max_count      = 3
    node_count     = 1
  }

  identity { type = "SystemAssigned" }

  role_based_access_control_enabled = true

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}

output "cluster_name" { value = azurerm_kubernetes_cluster.this.name }
