resource "azurerm_key_vault" "example" {
    for_each = var.kv
  name                        =  each.key
  location                    = each.value.location
  resource_group_name         = each.value.rg
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "Create"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
      
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
resource "azurerm_key_vault_secret" "example" {
    for_each = var.kv
  name         = each.value.secret-name
  value        = each.value.secreat-value
  key_vault_id = azurerm_key_vault.example[each.key].id
}

