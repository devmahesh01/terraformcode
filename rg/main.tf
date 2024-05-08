resource "azurerm_resource_group" "new" {
    for_each = var.rg
  name     = each.key
  location = each.value.location
}