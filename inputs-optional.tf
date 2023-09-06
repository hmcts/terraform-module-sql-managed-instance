variable "name" {
  default     = ""
  type        = string
  description = "The default name will be product+component+env, you can override the product+component part by setting this"
}

variable "admin_name" {
  type        = string
  description = "The admin username for the SQL Managed Instance."
  default     = "sqladmin"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "The admin password for the SQL Managed Instance."
  default     = null
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "existing_resource_group_name" {
  description = "Name of existing resource group to deploy resources into."
  type        = string
  default     = null
}

variable "enable_aad_integration" {
  description = "Enable Azure Active Directory integration, with PlatOps as the admins."
  type        = bool
  default     = true
}

variable "subnet_id" {
  type        = string
  description = "The Subnet ID to connect the SQL Managed Instance to."
  default     = null
}

variable "vnet_name" {
  type        = string
  description = "The VNet name to connect the SQL Managed Instance to."
  default     = null
}

variable "subnet_ip_range" {
  type        = string
  description = "The IP range of the subnet to connect the SQL Managed Instance to."
  default     = null
}

variable "databases" {
  type        = list(string)
  description = "The names of the managed databases to create."
  default     = []
}
