# In your modules/key_vault/outputs.tf

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "secret_uri" {
  description = "The full URI of the Key Vault secret, including its version, for App Service references."
  # For azurerm provider v4.x, you typically construct the URI
  # using the Key Vault's vault_uri and the secret's name and version.
  value = "${azurerm_key_vault.kv.vault_uri}secrets/${azurerm_key_vault_secret.sql_password.name}/${azurerm_key_vault_secret.sql_password.version}"
}

output "id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.kv.id
}
