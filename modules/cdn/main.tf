
# CDN Profile
resource "azurerm_cdn_profile" "static_website" {
  name                = var.cdn_profile_name
  location            = var.cdn_rg_location
  resource_group_name = var.cdn_rg_name
  sku                 = var.cdn_profile_sku

  tags = {
    environment = "demo"
    cost_center = "demo-cost-center"
  }
}

# CDN Endpoint
resource "azurerm_cdn_endpoint" "static_website" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.static_website.name
  location            = var.cdn_rg_location
  resource_group_name = var.cdn_rg_name
  origin_host_header  = var.cdn_primary_web_host

  origin {
    name      = "staticwebdemoportal"
    host_name = var.cdn_primary_web_host
  }

  # Rules for Rules Engine
  delivery_rule {
    name  = "spaURLReroute"
    order = "1"

    url_file_extension_condition {
      operator     = "LessThan"
      match_values = ["1"]
    }

    url_rewrite_action {
      destination             = "/index.html"
      preserve_unmatched_path = "false"
      source_pattern          = "/"
    }
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = "2"

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}