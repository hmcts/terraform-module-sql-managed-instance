resource "azurerm_resource_group" "new" {
  count = var.existing_resource_group_name == null ? 1 : 0

  name     = "${local.name}-${var.env}"
  location = var.location

  tags = module.ctags.common_tags
}

data "azurerm_resource_group" "existing" {
  count = var.existing_resource_group_name == null ? 0 : 1
  name  = var.existing_resource_group_name
}
