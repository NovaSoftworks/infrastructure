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

variable "k8s_sku_tier" {
  type        = string
  description = "Default SKU tier for Kubernetes cluster management."
}

variable "k8s_system_vm_size" {
  type        = string
  description = "Default VM size used for Kubernetes' system pool."
}

variable "k8s_system_node_count" {
  type        = string
  description = "How many nodes to use for Kubernetes' system pool."
}

variable "k8s_spot_vm_size" {
  type        = string
  description = "Default VM size used for Kubernetes' spot pool."
}

variable "k8s_spot_node_count" {
  type        = string
  description = "How many nodes to use for Kubernetes' spot pool."
}

variable "k8s_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the Kubernetes cluster will be connected."
}

variable "acr_id" {
  type        = string
  description = "The ID of the Azure Container Registry where Kubernetes will be able to pull images from."
}
