terraform {
  required_version = "1.15.5"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
