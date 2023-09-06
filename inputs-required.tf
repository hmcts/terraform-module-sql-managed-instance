variable "sqlmi_subnet_id" {
  type        = string
  description = "The Subnet ID to connect the SQL Managed Instance to."
}

variable "license_type" {
  type        = string
  description = "The type of license the Managed Instance will use"
}

variable "sku_name" {
  type        = string
  description = "The SKU Name for the SQL Managed Instance."
}

variable "vcores" {
  type        = number
  description = "Number of cores that should be assigned to the SQL Managed Instance."
}

variable "storage_size_in_gb" {
  type        = number
  description = "Maximum storage space for the SQL Managed instance."
}

variable "databases" {
  type        = list(string)
  description = "The names of the managed databases to create."
}

variable "env" {
  description = "Environment value"
  type        = string
}

variable "product" {
  description = "https://hmcts.github.io/glossary/#product"
  type        = string
}

variable "project" {
  description = "Project name - sds or cft."
}

variable "component" {
  description = "https://hmcts.github.io/glossary/#component"
  type        = string
}

variable "admin_group" {
  type = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
  default     = null
}

variable "business_area" {
  description = "business_area name - sds or cft."
}
