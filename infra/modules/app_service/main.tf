resource "azurerm_app_service_plan" "plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${var.container_image}"
    always_on        = true
  }

  app_settings = {
    WEBSITES_PORT                       = var.container_port
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}

output "app_url" {
  value = "https://${module.app_service.default_site_hostname}"
}

