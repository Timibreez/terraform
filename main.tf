provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    resource_group_name = "quality_release_rg"
    storage_account_name = "qualityrelease"
    container_name       = "timsblob"
    key                  = "terraform.timsblob"
  }
}
module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
# Reference the AppService Module here.
module "app_service" {
  source = "./modules/appservice"
  location             = "${var.location}"
  resource_group       = "${module.resource_group.resource_group_name}"
  application_type = "${var.application_type}"
  resource_type = "AppService"
  # tags = var.tags
}