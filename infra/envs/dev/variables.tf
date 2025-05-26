variable "location" {}
variable "resource_group" {}

# App Service
variable "plan_name" {}
variable "app_name" {}
variable "sku_tier" { default = "Basic" }
variable "sku_size" { default = "B1" }
variable "container_image" {}
variable "container_port" { default = "80" }

# Key Vault
variable "key_vault_name" {}
variable "secret_name" {}
variable "secret_value" {}
variable "key_vault_id" {}
# Monitoring
variable "app_insights_name" {}
variable "workspace_name" {}

# SQL
variable "sql_server_name" {}
variable "sql_db_name" {}
variable "sql_admin_user" {}
variable "sql_admin_password" {
  type = string
}
variable "db_sku" { default = "Basic" }

# Network
variable "vnet_name" {}
variable "subnet_name" {}
variable "nsg_name" {}
variable "address_space" {
  type = list(string)
}
variable "subnet_prefixes" {
  type = list(string)
}
