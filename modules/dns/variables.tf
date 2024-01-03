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
