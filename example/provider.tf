terraform {
  required_version = "1.12.1"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
