resource "azurerm_log_analytics_workspace" "logs" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.logs.id
}
