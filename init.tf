terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
