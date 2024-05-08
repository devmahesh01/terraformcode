resource "azurerm_resource_group" "new" {
    count = var.rg ? 6:0
  name     = "count-rg${count.index}"
  location = "westus"
}