terraform {
  required_version = "1.17.1"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
