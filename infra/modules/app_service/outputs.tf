output "app_service_name" {
  value = azurerm_linux_web_app.app.name
}

output "default_site_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}
