output "static_website_url" {
  value       = "https://${azurerm_cdn_endpoint.static_website.host_name}"
  description = "CDN Static Webiste Endpoint Url"
}
