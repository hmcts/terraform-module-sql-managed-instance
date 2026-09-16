terraform {
  required_version = "1.16.3"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
