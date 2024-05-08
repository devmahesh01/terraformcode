resource "azurerm_resource_group" "rt01" {
  for_each = var.rg
  name     = each.key
  location =  each.value.location
  tags = each.value.tags
}