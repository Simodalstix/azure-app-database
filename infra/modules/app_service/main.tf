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
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_identity.id]
  }

  app_settings = {
    "ConnectionStrings__DefaultConnection" = "@Microsoft.KeyVault(SecretUri=${module.key_vault.secret_uri})"
    WEBSITES_PORT                          = var.container_port
    WEBSITES_ENABLE_APP_SERVICE_STORAGE    = "false"
  }
}

resource "azurerm_user_assigned_identity" "app_identity" {
  name                = "app-identity-dev"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_key_vault_access_policy" "app" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.app_identity.principal_id

  secret_permissions = ["Get"]
}

output "app_url" {
  value = "https://${module.app_service.default_site_hostname}"
}

