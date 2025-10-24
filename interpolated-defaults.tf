locals {
  default_name   = var.component != "" ? "${var.product}-${var.component}" : var.product
  name           = var.name != "" ? var.name : local.default_name
  resource_group = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].name : data.azurerm_resource_group.existing[0].name
  location       = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].location : data.azurerm_resource_group.existing[0].location
  is_prod        = length(regexall(".*(prod).*", var.env)) > 0
  admin_group    = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"
  db_reader_user = local.is_prod ? "DTS JIT Access ${var.product} DB Reader SC" : "DTS ${upper(var.business_area)} DB Access Reader"
  admin_password = var.admin_password == null ? random_password.password[0].result : var.admin_password
  valid_skus     = ["gp_gen4", "gp_gen5", "gp_gen8im", "gp_gen8ih", "bc_gen4", "bc_gen5", "bc_gen8im", "bc_gen8ih"]
  vnet_name      = var.subnet_id == null && var.vnet_name == null ? azurerm_virtual_network.new[0].name : var.vnet_name
  subnet_id      = var.subnet_id == null ? azurerm_subnet.new[0].id : var.subnet_id
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azuread_group" "db_admin" {
  display_name     = local.admin_group
  security_enabled = true
}
