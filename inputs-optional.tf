variable "admin_name" {
  type        = string
  description = "The name of the admin user."
  default     = "VMAdmin"
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Name of existing resource group to deploy resources into"
  type        = string
  default     = null
}



