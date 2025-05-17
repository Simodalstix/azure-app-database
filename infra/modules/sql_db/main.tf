resource "azurerm_mssql_server" "sql_server" {
  name                         = var.server_name
  location                     = var.location
  resource_group_name          = var.resource_group
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "sql_db" {
  name      = var.db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.db_sku
}
