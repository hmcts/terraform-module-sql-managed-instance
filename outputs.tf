output "resource_group_name" {
  value = local.sqlmi_resource_group
}

output "resource_group_location" {
  value = local.sqlmi_location
}

# output "roles" {
#   value = data.azuread_directory_roles.current.object_ids
# }
