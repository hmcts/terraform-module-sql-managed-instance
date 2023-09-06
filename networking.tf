resource "azurerm_virtual_network" "new" {
  count               = var.subnet_id == null && var.vnet_name == null ? 1 : 0
  name                = "${local.name}-vnet-${var.env}"
  resource_group_name = local.resource_group
  location            = local.location
  address_space       = [var.subnet_ip_range]
  tags                = var.common_tags
}

resource "azurerm_subnet" "new" {
  count                = var.subnet_id == null ? 1 : 0
  name                 = "${local.name}-sqlmi-subnet-${var.env}"
  resource_group_name  = local.resource_group
  virtual_network_name = local.vnet_name
  address_prefixes     = [var.subnet_ip_range]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}
