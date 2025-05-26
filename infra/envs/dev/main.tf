provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group # Use variable from dev.tfvars
  location = var.location       # Use variable from dev.tfvars
}

module "network" {
  source          = "../../modules/network"
  vnet_name       = var.vnet_name       # Use variable from dev.tfvars
  subnet_name     = var.subnet_name     # Use variable from dev.tfvars
  nsg_name        = var.nsg_name        # Use variable from dev.tfvars
  address_space   = var.address_space   # Use variable from dev.tfvars
  subnet_prefixes = var.subnet_prefixes # Use variable from dev.tfvars
  location        = var.location
  resource_group  = azurerm_resource_group.main.name
}

module "monitoring" {
  source            = "../../modules/monitoring"
  workspace_name    = var.workspace_name    # Use variable from dev.tfvars
  app_insights_name = var.app_insights_name # Use variable from dev.tfvars
  location          = var.location
  resource_group    = azurerm_resource_group.main.name
}

module "sql" {
  source         = "../../modules/sql_db"
  server_name    = var.sql_server_name # Use variable from dev.tfvars
  db_name        = var.sql_db_name     # Use variable from dev.tfvars
  admin_user     = var.sql_admin_user
  admin_password = var.sql_admin_password
  db_sku         = var.db_sku # Use variable from dev.tfvars
  location       = var.location
  resource_group = azurerm_resource_group.main.name
}

module "app_service" {
  source          = "../../modules/app_service"
  plan_name       = var.plan_name # Use variable from dev.tfvars
  app_name        = var.app_name  # Use variable from dev.tfvars
  location        = var.location
  resource_group  = azurerm_resource_group.main.name # Use output from rg module if separate
  container_image = var.container_image
  container_port  = var.container_port # Use variable from dev.tfvars (ensure type matches module)
  key_vault_id    = module.key_vault.id
  tenant_id       = data.azurerm_client_config.current.tenant_id

  sku_tier = var.sku_tier # Use variable from dev.tfvars
  sku_size = var.sku_size # Use variable from dev.tfvars

  app_settings = {
    "ConnectionStrings__DefaultConnection" = "@Microsoft.KeyVault(SecretUri=${module.key_vault.secret_uri})"
    "WEBSITES_PORT"                        = var.container_port # Use variable if desired
    "NODE_ENV"                             = "production"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"  = "false"
  }
}

module "key_vault" {
  source         = "../../modules/key_vault"
  key_vault_name = var.key_vault_name # Use variable from dev.tfvars
  location       = var.location
  resource_group = azurerm_resource_group.main.name
  secret_name    = var.secret_name  # Use variable from dev.tfvars
  secret_value   = var.secret_value # Use variable from dev.tfvars
  # IMPORTANT: Remove key_vault_id here as it's an output of this module, not an input
}
