# Global
location = "australiasoutheast"
resource_group = "rg-todo-dev"
subscription_id = "b86a521f-c7a0-48c6-a0eb-f0d96d10f8ab"
# App Service Plan
plan_name = "asp-todo-dev"
sku_tier  = "Basic"
sku_size  = "B1"

# App Service
app_name        = "app-todo-dev"
container_image = "youracr.azurecr.io/todoapp:latest"
container_port  = "3000"

# Key Vault
key_vault_name  = "kv-todo-dev"
secret_name     = "DbPassword"
secret_value    = "SuperSecret123"
key_vault_id    = "/subscriptions/xxxx/resourceGroups/rg-todo-dev/providers/Microsoft.KeyVault/vaults/kv-todo-dev"

# Monitoring
app_insights_name = "appi-todo-dev"
workspace_name    = "log-todo-dev"

# SQL
sql_server_name     = "sqltodo-dev"
sql_db_name         = "tododb"
sql_admin_user      = "sqladmin"
sql_admin_password  = "SomeStrongP@ssword123!"

# Networking
vnet_name       = "vnet-todo-dev"
subnet_name     = "snet-todo-dev"
nsg_name        = "nsg-todo-dev"
address_space   = ["10.0.0.0/16"]
subnet_prefixes = ["10.0.1.0/24"]
