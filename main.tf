locals {
  admin_group    = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"

}

# Create managed instance
resource "azurerm_mssql_managed_instance" "sqlmi" {
  name                         = var.sqlmi_name
  resource_group_name          = var.sqlmi_resource_group
  location                     = var.sqlmi_location
  subnet_id                    = var.sqlmi_subnet_id
  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password
  license_type                 = var.license_type
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb

  private_dns_zone_id = var.public_access == true ? null : local.private_dns_zone_id

  tags = var.common_tags

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_client_config" "current" {
}

resource "azuread_directory_role" "reader" {
    display_name = "Directory Readers"
}

resource "azuread_directory_role_member" "sqlmireaderassignment" {
  role_object_id   = azuread_directory_role.reader.object_id
  member_object_id = azurerm_mssql_managed_instance.sqlmi.identity.0.principal_id
}

data "azuread_group" "sqlmi_admin" {
    display_name = local.admin_group
    security_enabled = true
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "sqlmi" {
  managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
  login_username      = "platops"
  object_id           = data.azuread_user.sql_admin.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  depends_on = [
    azurerm_mssql_managed_instance.sqlmi
  ]
}

resource "azurerm_mssql_managed_database" "misql_db" {
  name                = var.misql_db
  managed_instance_id = azurerm_mssql_managed_instance.misql.id
}


