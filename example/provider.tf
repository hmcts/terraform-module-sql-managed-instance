terraform {
  required_version = "1.6.0"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
