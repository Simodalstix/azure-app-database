provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-azureapp-dev"
  location = var.location
}

module "network" {
  source          = "../../modules/network"
  vnet_name       = "vnet-dev"
  subnet_name     = "subnet-dev"
  nsg_name        = "nsg-dev"
  address_space   = ["10.0.0.0/16"]
  subnet_prefixes = ["10.0.1.0/24"]
  location        = var.location
  resource_group  = azurerm_resource_group.main.name
}

module "monitoring" {
  source            = "../../modules/monitoring"
  workspace_name    = "logws-dev"
  app_insights_name = "appi-dev"
  location          = var.location
  resource_group    = azurerm_resource_group.main.name
}

module "sql" {
  source         = "../../modules/sql_db"
  server_name    = "sqlsrvdev"
  db_name        = "sqldbdev"
  admin_user     = var.sql_admin_user
  admin_password = var.sql_admin_password
  db_sku         = "Basic"
  location       = var.location
  resource_group = azurerm_resource_group.main.name
}

module "app_service" {
  source          = "../../modules/app_service"
  plan_name       = "plan-dev"
  app_name        = "app-dev"
  location        = var.location
  resource_group  = azurerm_resource_group.main.name
  container_image = var.container_image
  container_port  = 80
  key_vault_id    = module.key_vault.id                          # Assuming module.key_vault outputs its ID
  tenant_id       = data.azurerm_client_config.current.tenant_id # Assuming you have this data source

  app_settings = {
    "ConnectionStrings__DefaultConnection" = "@Microsoft.KeyVault(SecretUri=${module.key_vault.secret_uri})"
    "WEBSITES_PORT"                        = "3000"
    "NODE_ENV"                             = "production"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"  = "false" # Add this if you want it applied
  }
}

module "key_vault" {
  source         = "../../modules/key_vault"
  key_vault_name = "kv-dev"
  location       = var.location
  resource_group = azurerm_resource_group.main.name
  secret_name    = "DbConnectionString"
  secret_value   = "Server=tcp:sqlsrvdev.database.windows.net,1433;Initial Catalog=sqldbdev;Persist Security Info=False;User ID=sqladmin;Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

