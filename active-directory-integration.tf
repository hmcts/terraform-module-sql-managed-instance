resource "azurerm_mssql_managed_instance_active_directory_administrator" "sqlmi" {
  count               = var.enable_aad_integration ? 1 : 0
  managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
  login_username      = "DTS Platform Operations"
  object_id           = data.azuread_group.db_admin.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  depends_on = [
    azurerm_mssql_managed_instance.sqlmi
  ]
}
