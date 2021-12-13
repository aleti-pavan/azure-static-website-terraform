
resource "azurerm_storage_account" "static_website" {
  name                = substr(var.storage_account_name, 0, 23)
  resource_group_name = var.storage_rg_name

  location                 = var.storage_rg_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  static_website {
    index_document     = var.storage_index_document
    error_404_document = var.storage_error_document
  }
}

#Add index.html to blob storage
resource "azurerm_storage_blob" "static_website_index" {
  name                   = var.storage_index_document
  storage_account_name   = azurerm_storage_account.static_website.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.root}/files/index.html"
}

#Add error.html to blob storage
resource "azurerm_storage_blob" "static_website_error" {
  name                   = var.storage_error_document
  storage_account_name   = azurerm_storage_account.static_website.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.root}/files/error.html"
}