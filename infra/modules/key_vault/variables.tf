variable "key_vault_name" {
  description = "Name for the Azure Key Vault."
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

variable "secret_name" {
  description = "Name of the secret to store in Key Vault."
  type        = string
}

variable "secret_value" {
  description = "Value of the secret to store in Key Vault."
  type        = string
  sensitive   = true # Mark as sensitive so it's not shown in plan/apply output
}
