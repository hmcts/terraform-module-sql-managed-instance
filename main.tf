locals {
  default_name         = var.component != "" ? "${var.product}-${var.component}" : var.product
  name                 = var.name != "" ? var.name : local.default_name
  sqlmi_name           = "${local.name}-${var.env}"
  sqlmi_resource_group = var.resource_group_name == null ? azurerm_resource_group.rg[0].name : var.resource_group_name
  sqlmi_location       = var.resource_group_name == null ? azurerm_resource_group.rg[0].location : var.location
  env                  = var.env == "sandbox" ? "sbox" : var.env
  # vnet_rg_name         = var.business_area == "sds" ? "ss-${var.env}-network-rg" : "cft-${local.env}-network-rg"
  # vnet_name            = var.business_area == "sds" ? "ss-${var.env}-vnet" : "cft-${local.env}-vnet"

  is_prod = length(regexall(".*(prod).*", var.env)) > 0

  admin_group    = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"
  db_reader_user = local.is_prod ? "DTS JIT Access ${var.product} DB Reader SC" : "DTS ${upper(var.business_area)} DB Access Reader"
}

data "azurerm_client_config" "current" {}

data "azuread_group" "db_admin" {
  display_name     = local.admin_group
  security_enabled = true
}

# data "azuread_service_principal" "mi_name" {
#   count     = var.enable_read_only_group_access ? 1 : 0
#   object_id = var.admin_user_object_id
# }

# resource "random_password" "password" {
#   length = 20
#   # safer set of special characters for pasting in the shell
#   override_special = "()-_"
# }



# Create managed instance
resource "azurerm_mssql_managed_instance" "sqlmi" {
  name                         = local.sqlmi_name
  resource_group_name          = local.sqlmi_resource_group
  location                     = local.sqlmi_location
  subnet_id                    = var.sqlmi_subnet_id
  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password
  license_type                 = var.license_type
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb


  identity {
    type = "UserAssigned"
  }

  # authentication {
  #   active_directory_auth_enabled = true
  #   tenant_id                     = data.azurerm_client_config.current.tenant_id
  #   password_auth_enabled         = true
  # }

  tags = var.common_tags
}

# resource "azurerm_user_assigned_identity" "sqlmi-ui" {
#   location            = local.sqlmi_location
#   name                = "sqlmi-useridentity"
#   resource_group_name = local.sqlmi_resource_group
# }

resource "azurerm_mssql_managed_instance_active_directory_administrator" "sqlmi" {
  count               = var.enable_read_only_group_access ? 1 : 0
  managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
  login_username      = "platops"
  object_id           = data.azuread_group.db_admin.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  depends_on = [
    azurerm_mssql_managed_instance.sqlmi
  ]
}

resource "azurerm_mssql_managed_database" "sqlmi_db" {
  name                = var.sqlmi_db
  managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
}


