variable "license_type" {
  type        = string
  description = "The type of license the Managed Instance will use."
  validation {
    condition = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "Invalid value for license_type. Accepted values are: LicenseIncluded or BasePrice"
  }
}

variable "sku_name" {
  type        = string
  description = "The SKU Name for the SQL Managed Instance."
  validation {
    condition     = contains(["gp_gen4", "gp_gen5", "gp_gen8im", "gp_gen8ih", "bc_gen4", "bc_gen5", "bc_gen8im", "bc_gen8ih"], var.sku_name)
    error_message = "Invalid valid for sku_name. Accepted values are: GP_Gen4, GP_Gen5, GP_Gen8IM, GP_Gen8IH, BC_Gen4, BC_Gen5, BC_Gen8IM or BC_Gen8IH."
  }
}

variable "vcores" {
  type        = number
  description = "Number of cores that should be assigned to the SQL Managed Instance."
}

variable "storage_size_in_gb" {
  type        = number
  description = "Maximum storage space for the SQL Managed instance."
}

variable "env" {
  description = "Environment value"
  type        = string
}

variable "product" {
  description = "https://hmcts.github.io/cloud-native-platform/glossary/#product"
  type        = string
}

variable "project" {
  description = "Project name - sds or cft."
}

variable "component" {
  description = "https://hmcts.github.io/cloud-native-platform/glossary/#component"
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}

variable "business_area" {
  description = "business_area name - SDS or CFT."
  type        = string
  validation {
    condition     = contains(["sds", "cft"], lower(var.business_area))
    error_message = "Invalid valid for business_area. Valid values are: sds or cft."
  }
}
