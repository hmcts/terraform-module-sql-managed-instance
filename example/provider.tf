terraform {
  required_version = "1.16.1"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
