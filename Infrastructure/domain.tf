resource "azurerm_cdn_frontdoor_custom_domain" "michalgrzech_com_domain" {
  name                     = "michalgrzech-com-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id
  host_name                = "www.michalgrzech.com"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "michalgrzech_com_domain_root" {
  name                     = "michalgrzech-com-domain-root"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id
  host_name                = "michalgrzech.com"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "michalgrzech_pl_domain" {
  name                     = "michalgrzech-pl-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id
  host_name                = "www.michalgrzech.pl"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "michalgrzech_pl_domain_root" {
  name                     = "michalgrzech-pl-domain-root"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portfolio_fd.id
  host_name                = "michalgrzech.pl"

  tls {
    certificate_type = "ManagedCertificate"
  }
}
