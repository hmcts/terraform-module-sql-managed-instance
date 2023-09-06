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

variable "enable_read_only_group_access" {
  type        = bool
  default     = true
  description = "Enables read only group support for accessing the database"
}
