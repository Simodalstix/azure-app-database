variable "location" {
  default = "eastus"
}

variable "sql_admin_user" {}
variable "sql_admin_password" {
  sensitive = true
}

variable "container_image" {
  default = "youracr.azurecr.io/app:latest"
}
