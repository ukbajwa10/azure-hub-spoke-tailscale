terraform {
  backend "azurerm" {
    resource_group_name  = "RG-UKB-TERRAFORM"
    storage_account_name = "ukbtfstate"
    container_name       = "tfstate"
    key                  = "hub.terraform.tfstate"
    use_azuread_auth     = true
  }
}