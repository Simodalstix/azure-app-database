variable "plan_name" {}
variable "app_name" {}
variable "location" {}
variable "resource_group" {}
variable "sku_tier" { default = "Basic" }
variable "sku_size" { default = "B1" }
variable "container_image" {}
variable "container_port" { default = "80" }
variable "app_settings" {
  description = "A map of app settings for the Azure App Service."
  type        = map(string)
  default     = {} # Provide a default empty map if it's optional
}
variable "key_vault_id" {
  description = "The ID of the Key Vault to grant access to for the App Service's managed identity."
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID. Used for Key Vault access policies."
  type        = string
}
