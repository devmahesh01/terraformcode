data "azurerm_subnet" "example" {
    for_each = var.vm
  name                 = each.value.sub_name
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}