# terraform-module-template

<!-- TODO fill in resource name in link to product documentation -->
Terraform module for [Resource name](https://example.com).

## Example

<!-- todo update module name -->
```hcl
module "todo_resource_name" {
  source = "git@github.com:hmcts/terraform-module-todo?ref=main"
  ...
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 |

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role.reader](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) | resource |
| [azuread_directory_role_assignment.sqlmireaderassignment](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azurerm_mssql_managed_database.sqlmi_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_database) | resource |
| [azurerm_mssql_managed_instance.sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) | resource |
| [azurerm_mssql_managed_instance_active_directory_administrator.sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_active_directory_administrator) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azuread_group.sqlmi_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group"></a> [admin\_group](#input\_admin\_group) | n/a | `string` | n/a | yes |
| <a name="input_admin_name"></a> [admin\_name](#input\_admin\_name) | The name of the admin user. | `string` | `"VMAdmin"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Admin password for the SQL Managed Instance. | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/glossary/#component | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The type of license the Managed Instance will use | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/glossary/#product | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name - sds or cft. | `any` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU Name for the SQL Managed Instance. | `string` | n/a | yes |
| <a name="input_sqlmi_db"></a> [sqlmi\_db](#input\_sqlmi\_db) | The name of the Managed Database to create. | `string` | n/a | yes |
| <a name="input_sqlmi_location"></a> [sqlmi\_location](#input\_sqlmi\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_sqlmi_name"></a> [sqlmi\_name](#input\_sqlmi\_name) | The name of the SQL Managed Instance. | `string` | n/a | yes |
| <a name="input_sqlmi_resource_group"></a> [sqlmi\_resource\_group](#input\_sqlmi\_resource\_group) | The name of the resource group to deploy the SQL Managed Instance in. | `string` | n/a | yes |
| <a name="input_sqlmi_subnet_id"></a> [sqlmi\_subnet\_id](#input\_sqlmi\_subnet\_id) | The Subnet ID to connect the SQL Managed Instance to. | `string` | n/a | yes |
| <a name="input_storage_size_in_gb"></a> [storage\_size\_in\_gb](#input\_storage\_size\_in\_gb) | Maximum storage space for the SQL Managed instance. | `number` | n/a | yes |
| <a name="input_vcores"></a> [vcores](#input\_vcores) | Number of cores that should be assigned to the SQL Managed Instance. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
