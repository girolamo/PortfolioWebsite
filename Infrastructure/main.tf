resource "random_string" "random_storage_account" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "portfolio_rg" {
  name     = "PortfolioRG"
  location = "West Europe"
}

resource "azurerm_storage_account" "portfolio_sa" {
  name                       = "portfoliosa${random_string.random_storage_account.result}"
  resource_group_name        = azurerm_resource_group.portfolio_rg.name
  location                   = azurerm_resource_group.portfolio_rg.location
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true
}

resource "azurerm_storage_account_static_website" "portfolio_sa_static_website" {
  storage_account_id = azurerm_storage_account.portfolio_sa.id
  index_document     = "index.html"
  error_404_document = "index.html"
}
