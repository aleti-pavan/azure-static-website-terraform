locals {
  rg_name              = "${var.project_prefix}-${var.rg_name}"
  storage_account_name = "${var.project_prefix}1${var.storage_account_name}"
  cdn_profile_name     = "${var.project_prefix}-${var.cdn_profile_name}"
  cdn_endpoint_name    = "${var.project_prefix}-${var.cdn_endpoint_name}"
  storage_source       = "./files/index.html"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.rg_name
  location = var.rg_location
}

module "cdn" {
  source = "./modules/cdn"

  cdn_rg_name          = local.rg_name
  cdn_rg_location      = var.rg_location
  cdn_profile_name     = local.cdn_profile_name
  cdn_profile_sku      = var.cdn_profile_sku
  cdn_endpoint_name    = local.cdn_endpoint_name
  cdn_primary_web_host = module.storage.primary_web_host
  
  depends_on = [
    module.storage
  ]
}

module "storage" {
  source = "./modules/storage"

  storage_rg_name                  = local.rg_name
  storage_rg_location              = var.rg_location
  storage_source                   = local.storage_source
  storage_index_document           = var.static_website_index_doc
  storage_error_document           = var.static_website_error_doc
  storage_account_tier             = var.storage_account_tier
  storage_account_kind             = var.storage_account_kind
  storage_account_replication_type = var.storage_account_replication_type
  storage_account_name             = local.storage_account_name

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}