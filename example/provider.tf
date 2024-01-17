terraform {
  required_version = "1.6.6"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
