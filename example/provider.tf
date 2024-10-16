terraform {
  required_version = "1.9.8"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
