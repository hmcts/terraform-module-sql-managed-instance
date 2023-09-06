module "sqlmi" {
  source             = "git::https://github.com/hmcts/terraform-module-sql-managed-instance.git?ref=main"
  name               = "test-sqlmi"
  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  vcores             = 4
  databases          = ["testdb"]
  admin_name         = var.admin_name
  env                = "sbox"
  product            = var.product
  project            = var.project
  component          = var.component
  common_tags        = module.ctags.common_tags
  admin_group        = "DTS platform operations"
  business_area      = var.project
}
