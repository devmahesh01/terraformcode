resource "azurerm_subnet" "example" {
    for_each = var.subs
  name                 = each.key
  resource_group_name  = each.value.rg
  virtual_network_name = each.value.vnet
  address_prefixes     = each.value.address_prefixes
}