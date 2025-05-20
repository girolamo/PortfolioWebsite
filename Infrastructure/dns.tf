resource "azurerm_dns_zone" "michalgrzech_com" {
    name = "michalgrzech.com"
    resource_group_name = azurerm_resource_group.portfolio_rg.name
}  

resource "azurerm_dns_a_record" "michalgrzech_com_root" {
    name = "@"
    zone_name = azurerm_dns_zone.michalgrzech_com.name
    resource_group_name = azurerm_resource_group.portfolio_rg.name
    ttl = 300
    target_resource_id = azurerm_cdn_frontdoor_endpoint.portfolio_fd_endpoint.id
}

resource "azurerm_dns_cname_record" "michalgrzech_com_www" {
    name = "www"
    zone_name = azurerm_dns_zone.michalgrzech_com.name
    resource_group_name = azurerm_resource_group.portfolio_rg.name
    ttl = 300
    record = azurerm_cdn_frontdoor_endpoint.portfolio_fd_endpoint.host_name
}

resource "azurerm_dns_zone" "michalgrzech_pl" {
    name = "michalgrzech.pl"
    resource_group_name = azurerm_resource_group.portfolio_rg.name
}  

resource "azurerm_dns_a_record" "michalgrzech_pl_root" {
    name = "@"
    zone_name = azurerm_dns_zone.michalgrzech_pl.name
    resource_group_name = azurerm_resource_group.portfolio_rg.name
    ttl = 300
    target_resource_id = azurerm_cdn_frontdoor_endpoint.portfolio_fd_endpoint.id
}

resource "azurerm_dns_cname_record" "michalgrzech_pl_www" {
    name = "www"
    zone_name = azurerm_dns_zone.michalgrzech_pl.name
    resource_group_name = azurerm_resource_group.portfolio_rg.name
    ttl = 300
    record = azurerm_cdn_frontdoor_endpoint.portfolio_fd_endpoint.host_name
}