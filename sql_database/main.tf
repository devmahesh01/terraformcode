resource "azurerm_sql_server" "example" {
  for_each = var.db
  name                         = each.value.server_name
  resource_group_name          = each.value.rg
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.new09.value
  administrator_login_password = data.azurerm_key_vault_secret.example.value

  tags = {
    environment = each.value.env
  }
}
resource "azurerm_sql_database" "example" {
  for_each = var.db
  name                = each.key
  resource_group_name = each.value.rg
  location            = each.value.location
  server_name         = azurerm_sql_server.example[each.key].name

  tags = {
    environment = each.value.env
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}