terraform {
  required_version = "1.16.5"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
