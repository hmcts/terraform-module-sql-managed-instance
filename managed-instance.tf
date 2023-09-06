resource "random_password" "password" {
  count            = var.admin_password == null ? 1 : 0
  length           = 20
  override_special = "()-_"
}

resource "azurerm_user_assigned_identity" "sqlmi-ua" {
  location            = local.location
  name                = "${local.name}-mi-${var.env}"
  resource_group_name = local.resource_group
}

resource "azurerm_mssql_managed_instance" "sqlmi" {
  name                         = "${local.name}-${var.env}"
  resource_group_name          = local.resource_group
  location                     = local.location
  subnet_id                    = local.subnet_id
  administrator_login          = var.admin_name
  administrator_login_password = local.admin_password
  license_type                 = var.license_type
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sqlmi-ua.id]
  }

  tags = var.common_tags
}
