variable "rg_name" {}
variable "rg_location" {
  default = "westus"
}
variable "project_prefix" {
  default = "aleti"
}
variable "storage_account_name" {}
variable "static_website_index_doc" {
  default = "index.html"
}
variable "static_website_error_doc" {
  default = "error.html"
}

variable "cdn_profile_name" {
  default = "cdn-profile"
}
variable "cdn_profile_sku" {
  default = "Standard_Microsoft"
}
variable "cdn_endpoint_name" {
  default = "cdn-endpoint"
}
variable "storage_account_tier" {
  default = "Standard"
}
variable "storage_account_kind" {
  default = "StorageV2"
}
variable "storage_account_replication_type" {
  default = "LRS"
}

