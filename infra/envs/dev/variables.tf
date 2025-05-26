# Global
variable "location" {
  description = "The Azure region to deploy resources to."
  type        = string
}
variable "resource_group" {
  description = "The name of the main resource group."
  type        = string
}
variable "subscription_id" {
  type = string
}

# App Service Plan
variable "plan_name" {
  description = "Name for the App Service plan."
  type        = string
}
variable "sku_tier" {
  description = "Tier for the App Service plan SKU (e.g., Basic, Standard)."
  type        = string
  default     = "Basic" # Keep the default if you want to reuse it
}
variable "sku_size" {
  description = "Size for the App Service plan SKU (e.g., B1, S1)."
  type        = string
  default     = "B1" # Keep the default if you want to reuse it
}

# App Service
variable "app_name" {
  description = "Name for the App Service web app."
  type        = string
}
variable "container_image" {
  description = "Docker image for the web app."
  type        = string
}
variable "container_port" {
  description = "Container port for the web app."
  type        = string # Keep as string if you are passing string like "3000"
  default     = "80"
}

# Key Vault
variable "key_vault_name" {
  description = "Name for the Azure Key Vault."
  type        = string
}
variable "secret_name" {
  description = "Name of the secret to store in Key Vault."
  type        = string
}
variable "secret_value" {
  description = "Value of the secret to store in Key Vault."
  type        = string
  sensitive   = true # Mark as sensitive
}
variable "key_vault_id" { # This variable is used to pass the ID, but it's often an output of another module
  description = "The full resource ID of the Key Vault."
  type        = string
}


# Monitoring
variable "app_insights_name" {
  description = "Name for the Application Insights resource."
  type        = string
}
variable "workspace_name" {
  description = "Name for the Log Analytics Workspace."
  type        = string
}

# SQL
variable "sql_server_name" {
  description = "Name for the SQL server."
  type        = string
}
variable "sql_db_name" {
  description = "Name for the SQL database."
  type        = string
}
variable "sql_admin_user" {
  description = "Admin username for the SQL server."
  type        = string
}
variable "sql_admin_password" {
  description = "Admin password for the SQL server."
  type        = string
  sensitive   = true # Mark as sensitive
}
variable "db_sku" {
  description = "SKU for the SQL database (e.g., Basic, S0)."
  type        = string
  default     = "Basic"
}

# Networking
variable "vnet_name" {
  description = "Name for the Virtual Network."
  type        = string
}
variable "subnet_name" {
  description = "Name for the subnet."
  type        = string
}
variable "nsg_name" {
  description = "Name for the Network Security Group."
  type        = string
}
variable "address_space" {
  description = "Address space for the VNet."
  type        = list(string)
}
variable "subnet_prefixes" {
  description = "Subnet prefixes for the VNet."
  type        = list(string)
}
