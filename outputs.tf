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
