terraform {
  required_version = "1.12.2"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
