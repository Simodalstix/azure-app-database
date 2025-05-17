variable "plan_name" {}
variable "app_name" {}
variable "location" {}
variable "resource_group" {}
variable "sku_tier" { default = "Basic" }
variable "sku_size" { default = "B1" }
variable "container_image" {}
variable "container_port" { default = "80" }
