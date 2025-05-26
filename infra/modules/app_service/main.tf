# In ../../modules/app_service/main.tf

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_app_service_plan.plan.id # Assuming azurerm_app_service_plan.plan is defined within this module

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_identity.id]
  }

  app_settings = var.app_settings

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|${var.container_image}"
  }
}

resource "azurerm_user_assigned_identity" "app_identity" {
  name                = "app-identity-dev" # You might want to make this name dynamic using a variable
  location            = var.location
  resource_group_name = var.resource_group # Use var.resource_group as it's passed into the module
}

resource "azurerm_key_vault_access_policy" "app" {
  # These now correctly use the variables passed into this module
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.app_identity.principal_id

  secret_permissions = ["Get"]
}

# Assuming this App Service Plan is defined within this module
resource "azurerm_app_service_plan" "plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group
  kind                = "Linux"
  sku {
    tier = var.sku_tier # Using variables for flexibility
    size = var.sku_size # Using variables for flexibility
  }
}

output "app_url" {
  # This output should typically reference an attribute of the web app created in this module.
  # azurerm_linux_web_app.app.default_hostname is the correct attribute.
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
  description = "The default URL of the deployed App Service."
}
