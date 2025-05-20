resource "azurerm_cdn_frontdoor_profile" "portfolio_fd" {
  name                = "PortfolioFD"
  resource_group_name = azurerm_resource_group.portfolio_rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "portfolio_fd_endpoint" {
  name                     = "portfolio"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id
}

resource "azurerm_cdn_frontdoor_origin_group" "portfolio_fd_origin_group" {
  name                     = "portfolio-og"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id

  health_probe {
    interval_in_seconds = 60
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    successful_samples_required        = 1
    sample_size                        = 4
    additional_latency_in_milliseconds = 0
  }
}

resource "azurerm_cdn_frontdoor_origin" "portfolio_fd_origin" {
  name                           = "portfolio-o"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.portfolio_fd_origin_group.id
  host_name                      = azurerm_storage_account.portfolio_sa.primary_web_host
  origin_host_header             = azurerm_storage_account.portfolio_sa.primary_web_host
  enabled                        = true
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = false
}

resource "azurerm_cdn_frontdoor_route" "portfolio_fd_route" {
  name                          = "portfolio-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.portfolio_fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.portfolio_fd_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.portfolio_fd_origin.id]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.michalgrzech_com_domain.id,
    azurerm_cdn_frontdoor_custom_domain.michalgrzech_com_domain_root.id,
    azurerm_cdn_frontdoor_custom_domain.michalgrzech_pl_domain.id,
  azurerm_cdn_frontdoor_custom_domain.michalgrzech_pl_domain_root.id]

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]
}