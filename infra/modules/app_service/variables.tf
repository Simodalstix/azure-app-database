variable "app_name" {
  description = "Name for the App Service web app."
  type        = string
}

variable "location" {
  description = "Azure region for resources."
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group."
  type        = string
}

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

variable "container_image" {
  description = "Docker image for the web app."
  type        = string
}

variable "container_port" {
  description = "Container port for the web app."
  type        = number # Changed to number as ports are typically numbers
  default     = 80
}

variable "key_vault_id" {
  description = "ID of the Key Vault for secret access."
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID."
  type        = string
}

variable "app_settings" {
  description = "Application settings for the web app."
  type        = map(string)
  default     = {}
}
