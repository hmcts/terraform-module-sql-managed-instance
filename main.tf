

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

  #   private_dns_zone_id = var.public_access == true ? null : local.private_dns_zone_id


  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags
}


resource "azurerm_virtual_network" "managed_sql_vnet" {
  name                = "vnet-mi"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/24"]
  location            = var.location
  tags                = var.common_tags
}

resource "azurerm_subnet" "vnet_subnet" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.managed_sql_vnet.name
  address_prefixes     = ["10.0.0.0/27"]


  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}



# data "azurerm_client_config" "current" {
# }

# resource "azuread_directory_role" "reader" {
#     display_name = "Directory Readers"
# }

# resource "azuread_group" "sqlmi_admin" {
#     display_name = var.admin_group
#     security_enabled = true
# }

# resource "azuread_directory_role_assignment" "sqlmireaderassignment" {

#   role_id   = azuread_directory_role.reader.object_id
#   principal_object_id = data.azuread_group.sqlmi_admin.object_id
# }


# resource "azurerm_mssql_managed_instance_active_directory_administrator" "sqlmi" {
#   managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
#   login_username      = "platops"
#   object_id           = azuread_group.sqlmi_admin.object_id
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   depends_on = [
#     azurerm_mssql_managed_instance.sqlmi
#   ]
# }

# resource "azurerm_mssql_managed_database" "sqlmi_db" {
#   name                = var.sqlmi_db
#   managed_instance_id = azurerm_mssql_managed_instance.sqlmi.id
# }


