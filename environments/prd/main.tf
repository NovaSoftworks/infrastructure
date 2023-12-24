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
      name = "global-infrastructure-prd"
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
