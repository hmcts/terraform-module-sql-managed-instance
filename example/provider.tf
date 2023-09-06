terraform {
  required_version = "1.5.6"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "random" {}
