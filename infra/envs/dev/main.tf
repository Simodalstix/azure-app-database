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
  source         = "../../modules/sql"
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
}
module "key_vault" {
  source         = "../../modules/key_vault"
  key_vault_name = "kv-dev"
  location       = var.location
  resource_group = azurerm_resource_group.main.name
  secret_name    = "SqlPassword"
  secret_value   = var.sql_admin_password
}
