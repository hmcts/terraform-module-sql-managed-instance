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

resource "azurerm_network_security_group" "this" {
  count               = var.subnet_id == null ? 1 : 0
  name                = "${local.name}-nsg-${var.env}"
  location            = local.location
  resource_group_name = local.resource_group
  tags                = var.common_tags
}


resource "azurerm_network_security_rule" "allow_management_inbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_management_inbound"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "allow_misubnet_inbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_misubnet_inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_management_outbound"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "12000"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "allow_misubnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_network_security_rule" "deny_all_outbound" {
  count                       = var.subnet_id == null ? 1 : 0
  name                        = "deny_all_outbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group
  network_security_group_name = azurerm_network_security_group.this[0].name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.subnet_id == null ? 1 : 0
  subnet_id                 = azurerm_subnet.new[0].id
  network_security_group_id = azurerm_network_security_group.this[0].id
}

resource "azurerm_route_table" "this" {
  count                         = var.subnet_id == null ? 1 : 0
  name                          = "${local.name}-rt-${var.env}"
  location                      = local.location
  resource_group_name           = local.resource_group
  disable_bgp_route_propagation = false
  tags                          = var.common_tags
  depends_on = [
    azurerm_subnet.new
  ]
}

resource "azurerm_subnet_route_table_association" "this" {
  count          = var.subnet_id == null ? 1 : 0
  subnet_id      = azurerm_subnet.new[0].id
  route_table_id = azurerm_route_table.this[0].id
}
