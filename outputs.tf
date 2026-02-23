output "resource_group_name" {
  value       = local.resource_group
  description = "The name of the resource group resources have been deployed to."
}

output "location" {
  value       = local.location
  description = "The Azure region resources have been deployed to."
}

output "sql_managed_instance_id" {
  value       = azurerm_mssql_managed_instance.sqlmi.id
  description = "The ID of the SQL Managed Instance."
}

output "database_ids" {
  value       = [for db in azurerm_mssql_managed_database.this : db.id]
  description = "The IDs of the SQL Managed Databases."
}

output "vnet_id" {
  value       = var.subnet_id == null && var.vnet_name == null ? azurerm_virtual_network.new[0].id : null
  description = "The ID of the VNet, this will be null if a subnet ID is provided to the module instead."
}

output "subnet_id" {
  value       = var.subnet_id == null ? azurerm_subnet.new[0].id : null
  description = "The ID of the subnet, this will be null if a subnet ID is provided to the module instead."
}

output "sql_managed_instance_fqdn" {
  value       = azurerm_mssql_managed_instance.sqlmi.fqdn
  description = "The fully qualified domain name (FQDN) of the SQL Managed Instance."
}

output "admin_password" {
  value       = local.admin_password
  description = "The password used for the admin user, either passed in via vars or generated."
}
