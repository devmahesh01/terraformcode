data "azurerm_subnet" "example" {
    for_each = var.vm
  name                 = each.value.sub_name
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}
data "azurerm_key_vault" "example" {
  name                = "rg-kv-ws-01"
  resource_group_name = "rg01"
}
data "azurerm_key_vault_secret" "new09" {
  name         = "azureadmin01"
  key_vault_id = data.azurerm_key_vault.example.id
}
