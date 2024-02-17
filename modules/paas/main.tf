locals {
  component            = "novacp-${var.environment}-${var.region_short}-paas"
  orchestrator_version = "1.29.1"
}

resource "azurerm_resource_group" "paas_rg" {
  name     = "${local.component}-rg"
  location = var.region

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "paas_k8s" {
  name                = local.component
  resource_group_name = azurerm_resource_group.paas_rg.name
  location            = azurerm_resource_group.paas_rg.location
  dns_prefix          = "dns-paas-${var.region_short}-${var.environment}-novacp"
  sku_tier            = var.paas_sku_tier

  identity {
    type = "SystemAssigned"
  }

  node_resource_group = "${local.component}-node-rg"

  default_node_pool {
    name                 = "default"
    node_count           = var.paas_system_node_count
    vm_size              = var.paas_system_vm_size
    vnet_subnet_id       = var.paas_subnet_id
    os_disk_size_gb      = 30
    orchestrator_version = local.orchestrator_version
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "paas_spot_pool" {
  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.paas_k8s.id
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = "8"
  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]
  node_count     = var.paas_spot_node_count
  vm_size        = var.paas_spot_vm_size
  vnet_subnet_id = var.paas_subnet_id
  //os_disk_size_gb      = 30
  orchestrator_version = local.orchestrator_version

  tags = {
    environment = var.environment
  }
}
