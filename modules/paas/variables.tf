variable "environment" {
  type        = string
  description = "This is the environment where the infrastructure will be deployed."
}

variable "region" {
  type        = string
  description = "This is the cloud hosting region the infrastructure will be deployed."
}

variable "region_short" {
  type        = string
  description = "This is the cloud hosting region where the infrastructure will be deployed, but shortened."
}

variable "paas_sku_tier" {
  type        = string
  description = "Default SKU tier for the PaaS cluster management."
}

variable "paas_system_vm_size" {
  type        = string
  description = "Default VM size used for the PaaS' system pool."
}

variable "paas_system_node_count" {
  type        = string
  description = "How many nodes to use for the PaaS' system pool."
}

variable "paas_spot_vm_size" {
  type        = string
  description = "Default VM size used for the PaaS' spot pool."
}

variable "paas_spot_node_count" {
  type        = string
  description = "How many nodes to use for the PaaS' spot pool."
}

variable "paas_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the PaaS cluster will be connected."
}
