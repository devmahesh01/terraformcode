
resource "azurerm_virtual_network" "example" {
  name                = "myvnet01"
  location            = "west us"
  resource_group_name = "rg015"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
dynamic "subnet" {
    for_each = var.subnets == null ? {}:var.subnets 
    content {
      name = subnet.value.subname
      address_prefix = subnet.value.address_prefix
      security_group = subnet.value.security_group
    }
  
}


  tags = {
    environment = "Production"
  }
}