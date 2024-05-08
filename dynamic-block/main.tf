resource "azurerm_network_security_group" "example" {
  name                = "azurensg01"
  location            = "West US"
  resource_group_name = "count-rg4"
  dynamic "security_rule" {
    for_each = var.rule
    content  {
        name                   = security_rule.value.rule-name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          =  security_rule.value.source_port_range 
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      =  "*"
    destination_address_prefix =  "*"
    }
    
  }

  tags = {
    environment = "Production"
  }
}