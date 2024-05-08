resource "azurerm_virtual_network" "new" {
    for_each = var.vnet
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.rg
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
}