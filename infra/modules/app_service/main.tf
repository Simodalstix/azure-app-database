resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.dev_plan.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_identity.id]
  }

  app_settings = merge(
    var.app_settings, # Include your existing app_settings
    {
      "DOCKER_CUSTOM_IMAGE_NAME"            = var.container_image
      "DOCKER_REGISTRY_SERVER_URL"          = "https://youracr.azurecr.io"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
      "WEBSITES_PORT"                       = var.container_port
    }
  )

  site_config {
    always_on = true

  }
}

resource "azurerm_user_assigned_identity" "app_identity" {
  name                = "app-identity-dev" # Might make dynamic variable
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_key_vault_access_policy" "app" {

  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.app_identity.principal_id

  secret_permissions = ["Get"]
}

resource "azurerm_service_plan" "dev_plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = var.sku_size
}

output "app_url" {
  # This output should typically reference an attribute of the web app created in this module.
  # azurerm_linux_web_app.app.default_hostname is the correct attribute.
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
  description = "The default URL of the deployed App Service."
}
