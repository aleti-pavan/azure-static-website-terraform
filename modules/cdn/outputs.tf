output "static_website_url" {
  value       = azurerm_cdn_endpoint.static_website.origin
  description = "CDN Static Webiste Endpoint Url"
}
