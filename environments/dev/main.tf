terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.92"
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

module "paas" {
  source     = "../../modules/paas"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  paas_sku_tier          = var.paas_sku_tier
  paas_system_vm_size    = var.paas_system_vm_size
  paas_system_node_count = var.paas_system_node_count
  paas_spot_vm_size      = var.paas_spot_vm_size
  paas_spot_node_count   = var.paas_spot_node_count

  paas_subnet_id = module.network.paas_subnet_id
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
