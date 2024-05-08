resource "azurerm_virtual_network" "example" {
    for_each = var.vnet
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers


  dynamic "subnet" {
    for_each = var.subs == null?{}:var.subs
    content {
        name           = subnet.value.name
    address_prefix =    subnet.value.address_prefix 
    security_group = subnet.value.security_group
      
    }
    
}
}