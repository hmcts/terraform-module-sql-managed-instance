terraform {
  required_version = "1.12.0"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
