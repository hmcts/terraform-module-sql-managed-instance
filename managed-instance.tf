resource "random_password" "password" {
  count            = var.admin_password == null ? 1 : 0
  length           = 20
  override_special = "()-_"
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

  dynamic "identity" {
    for_each = var.user_assigned_managed_identity_id == null ? [] : [var.user_assigned_managed_identity_id]
    content {
      type         = "UserAssigned"
      identity_ids = [identity.value]
    }
  }

  depends_on = [azurerm_subnet_network_security_group_association.this, azurerm_subnet_route_table_association.this]

  tags = var.common_tags
}
