terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2"
    }
  }
  cloud {
    organization = "NovaSoftworks"
    workspaces {
      name = "infrastructure-dev"
    }
  }
}

provider "azurerm" {
  features {}
}

module "container_registry" {
  source = "../../modules/container_registry"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}

module "dns" {
  source = "../../modules/dns"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}

module "network" {
  source = "../../modules/network"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}

module "k8s" {
  source     = "../../modules/k8s"
  depends_on = [module.network, module.container_registry]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  k8s_sku_tier          = var.k8s_sku_tier
  k8s_system_vm_size    = var.k8s_system_vm_size
  k8s_system_node_count = var.k8s_system_node_count
  k8s_spot_vm_size      = var.k8s_spot_vm_size
  k8s_spot_node_count   = var.k8s_spot_node_count

  k8s_subnet_id = module.network.k8s_subnet_id

  acr = module.container_registry.acr
}

module "jumpbox" {
  source     = "../../modules/vm"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  vm_name     = "jumpbox"
  vm_size     = var.jumpbox_vm_size
  vm_username = var.jumpbox_username
  vm_password = var.jumpbox_password

  vm_subnet_id = module.network.vms_subnet_id
}
