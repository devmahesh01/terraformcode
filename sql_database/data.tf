data "azurerm_key_vault" "example" {
  name                = "rg-kv-ws-prod-dev01"
  resource_group_name = "web-rg"
}
data "azurerm_key_vault_secret" "new09" {
  name         = "administrator-login"
  key_vault_id = data.azurerm_key_vault.example.id
}
data "azurerm_key_vault_secret" "example" {
  name         = "administrator-login-password"
  key_vault_id = data.azurerm_key_vault.example.id
}
