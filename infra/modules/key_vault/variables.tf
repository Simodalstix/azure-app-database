
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}
variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}
variable "resource_group" {
  description = "The name of the resource group."
  type        = string
}
variable "secret_name" {
  description = "The name of the secret to store in Key Vault."
  type        = string
}
variable "secret_value" {
  description = "The value of the secret to store in Key Vault."
  type        = string
  sensitive   = true # Mark as sensitive to prevent logging
}
