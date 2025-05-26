output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "secret_uri" {
  # Change this line: Use versionless_secret_uri for App Service references
  value = azurerm_key_vault_secret.sql_password.versionless_secret_uri
}
output "id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.kv.id
}
