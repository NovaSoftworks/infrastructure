locals {
  component            = "novacp-${var.environment}-${var.region_short}-k8s"
  orchestrator_version = "1.27.7"
}

resource "azurerm_resource_group" "k8s_rg" {
  name     = "${local.component}-rg"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = local.component
  resource_group_name = azurerm_resource_group.k8s_rg.name
  location            = azurerm_resource_group.k8s_rg.location
  dns_prefix          = "dns-k8s-${var.region_short}-${var.environment}-novacp"
  sku_tier            = var.k8s_sku_tier

  identity {
    type = "SystemAssigned"
  }

  node_resource_group = "${local.component}-node-rg"

  default_node_pool {
    name                 = "default"
    node_count           = var.k8s_system_node_count
    vm_size              = var.k8s_system_vm_size
    vnet_subnet_id       = var.k8s_subnet_id
    os_disk_size_gb      = 30
    orchestrator_version = local.orchestrator_version
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "k8s_spot_pool" {
  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = "8"
  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]
  node_count     = var.k8s_spot_node_count
  vm_size        = var.k8s_spot_vm_size
  vnet_subnet_id = var.k8s_subnet_id
  //os_disk_size_gb      = 30
  orchestrator_version = local.orchestrator_version
}
