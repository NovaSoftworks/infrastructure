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

variable "vm_name" {
  type        = string
  description = "VM name."
}

variable "vm_username" {
  type        = string
  description = "VM administrator username."
}

variable "vm_password" {
  type        = string
  description = "VM administrator password."
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "Default VM size used for the VM."
}

variable "vm_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the VM will be connected."
}
