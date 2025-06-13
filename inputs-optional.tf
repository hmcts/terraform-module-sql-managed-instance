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

variable "user_assigned_managed_identity_id" {
  type        = string
  description = "The ID of an existing user assigned managed identity to use for the SQL Managed Instance. Required to AAD integration and must be assigned the Directory Reeader role."
  default     = null
}

variable "enable_system_assigned_identity" {
  description = "Enable SystemAssigned managed identity"
  type        = bool
  default     = true
}

variable "collation" {
  type        = string
  description = "Specifies how the SQL Managed Instance will be collated."
  default     = "Latin1_General_CI_AS"
}
