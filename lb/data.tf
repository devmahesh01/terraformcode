data "azurerm_virtual_machine" "example" {
  name                = "vm01"
  resource_group_name = "lb-rg"
}
data "azurerm_virtual_machine" "new01" {
  name                = "vm02"
  resource_group_name = "lb-rg"
}
data "azurerm_virtual_network" "example" {
  name                = "lb-vnet01"
  resource_group_name = "lb-rg"
}