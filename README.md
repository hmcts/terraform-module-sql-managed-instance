# terraform-module-sql-managed-instance

Terraform module for [Azure SQL Managed Instance](https://azure.microsoft.com/en-gb/products/azure-sql/managed-instance/).

To use AAD Authentication to must provide a User Assigned Managed Identity ID that has the `Directory Reader` role in AAD.

## Example
The module can use an existing Resource Group, VNet and Subnet or it can create basic forms these for you. There are two example below, one using existing resources and the other letting the module create these resources.

### New RG, VNet & Subnet Example
```hcl
module "sqlmi" {
  source             = "git::https://github.com/hmcts/terraform-module-sql-managed-instance.git?ref=main"
  name               = "test-sqlmi"
  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  vcores             = 4
  databases          = ["testdb"]
  admin_name         = var.admin_name
  subnet_ip_range    = "10.10.10.0/27"
  env                = "sbox"
  product            = var.product
  project            = var.project
  component          = var.component
  common_tags        = var.common_tags
  business_area      = var.project
}
```

### Existing RG, VNet & Subnet Example
```hcl
module "sqlmi" {
  source                       = "git::https://github.com/hmcts/terraform-module-sql-managed-instance.git?ref=main"
  name                         = "test-sqlmi"
  license_type                 = "BasePrice"
  sku_name                     = "GP_Gen5"
  storage_size_in_gb           = 32
  vcores                       = 4
  databases                    = ["testdb"]
  admin_name                   = var.admin_name
  existing_resource_group_name = "my-sqlmi-rg"
  subnet_id                    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-sqlmi-rg/providers/Microsoft.Network/virtualNetworks/my-sqlmi-vnet/subnets/sqlmi-subnet"
  env                          = "sbox"
  product                      = var.product
  project                      = var.project
  component                    = var.component
  common_tags                  = var.common_tags
  business_area                = var.project
}
```

### Enable AAD Authentication
```hcl
resource "azurerm_user_assigned_identity" "uami" {
  location            = "uksouth"
  name                = "my-sqlmi-uami"
  resource_group_name = "my-sqlmi-rg"
  tags                = var.common_tags
}

module "sqlmi" {
  source                            = "git::https://github.com/hmcts/terraform-module-sql-managed-instance.git?ref=main"
  name                              = "test-sqlmi"
  license_type                      = "BasePrice"
  sku_name                          = "GP_Gen5"
  storage_size_in_gb                = 32
  vcores                            = 4
  databases                         = ["testdb"]
  admin_name                        = var.admin_name
  existing_resource_group_name      = "my-sqlmi-rg"
  subnet_id                         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-sqlmi-rg/providers/Microsoft.Network/virtualNetworks/my-sqlmi-vnet/subnets/sqlmi-subnet"
  env                               = "sbox"
  product                           = var.product
  project                           = var.project
  component                         = var.component
  common_tags                       = var.common_tags
  business_area                     = var.project
  user_assigned_managed_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/my-sqlmi-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-sqlmi-uami"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.48.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.71.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.48.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_managed_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/mssql_managed_database) | resource |
| [azurerm_mssql_managed_instance.sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/mssql_managed_instance) | resource |
| [azurerm_mssql_managed_instance_active_directory_administrator.sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/mssql_managed_instance_active_directory_administrator) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.allow_health_probe_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_management_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_management_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_misubnet_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_misubnet_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_tds_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.deny_all_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.deny_all_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/resource_group) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/route_table) | resource |
| [azurerm_subnet.new](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.new](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/virtual_network) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [azuread_group.db_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.48.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.existing](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_name"></a> [admin\_name](#input\_admin\_name) | The admin username for the SQL Managed Instance. | `string` | `"sqladmin"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The admin password for the SQL Managed Instance. | `string` | `null` | no |
| <a name="input_business_area"></a> [business\_area](#input\_business\_area) | business\_area name - SDS or CFT. | `string` | n/a | yes |
| <a name="input_collation"></a> [collation](#input\_collation) | Specifies how the SQL Managed Instance will be collated. | `string` | `"Latin1_General_CI_AS"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common Tags | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/cloud-native-platform/glossary/#component | `string` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | The names of the managed databases to create. | `list(string)` | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing resource group to deploy resources into. | `string` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The type of license the Managed Instance will use. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name will be product+component+env, you can override the product+component part by setting this | `string` | `""` | no |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/cloud-native-platform/glossary/#product | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name - sds or cft. | `any` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU Name for the SQL Managed Instance. | `string` | n/a | yes |
| <a name="input_storage_size_in_gb"></a> [storage\_size\_in\_gb](#input\_storage\_size\_in\_gb) | Maximum storage space for the SQL Managed instance. | `number` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The Subnet ID to connect the SQL Managed Instance to. | `string` | `null` | no |
| <a name="input_subnet_ip_range"></a> [subnet\_ip\_range](#input\_subnet\_ip\_range) | The IP range of the subnet to connect the SQL Managed Instance to. | `string` | `null` | no |
| <a name="input_user_assigned_managed_identity_id"></a> [user\_assigned\_managed\_identity\_id](#input\_user\_assigned\_managed\_identity\_id) | The ID of an existing user assigned managed identity to use for the SQL Managed Instance. Required to AAD integration and must be assigned the Directory Reeader role. | `string` | `null` | no |
| <a name="input_vcores"></a> [vcores](#input\_vcores) | Number of cores that should be assigned to the SQL Managed Instance. | `number` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The VNet name to connect the SQL Managed Instance to. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_ids"></a> [database\_ids](#output\_database\_ids) | The IDs of the SQL Managed Databases. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region resources have been deployed to. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group resources have been deployed to. |
| <a name="output_sql_managed_instance_id"></a> [sql\_managed\_instance\_id](#output\_sql\_managed\_instance\_id) | The ID of the SQL Managed Instance. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the subnet, this will be null if a subnet ID is provided to the module instead. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the VNet, this will be null if a subnet ID is provided to the module instead. |
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
