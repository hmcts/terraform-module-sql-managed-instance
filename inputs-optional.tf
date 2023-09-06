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

variable "enable_read_only_group_access" {
  type        = bool
  default     = true
  description = "Enables read only group support for accessing the database"
}

# variable "admin_user_object_id" {
#   default     = null
#   description = "The ID of the principal to be granted admin access to the database server, should be the principal running this normally. If you are using Jenkins pass through the variable 'jenkins_AAD_objectId'."
# }




