resource "azurerm_storage_account" "example" {
    for_each = var.stg
  name                     = each.key
  resource_group_name      = each.value.rg
  location                 = each.value.location
  account_tier             = each.value.account_tier  
  account_replication_type = each.value.account_replication_type

  tags = {
    environment =each.value.env
  }
}

resource "azurerm_storage_container" "ja" {
    for_each = var.stg
  name                  = each.value.con_name
  storage_account_name  = azurerm_storage_account.example[each.key].name
  container_access_type = "private"
}
resource "azurerm_storage_queue" "example" {
    for_each = var.stg
  name                 = each.value.queue_name
  storage_account_name = azurerm_storage_account.example[each.key].name
}
resource "azurerm_storage_share" "example" {
    for_each = var.stg 
  name                 =  each.value.share_name
  storage_account_name = azurerm_storage_account.example[each.key].name
  quota                = 50
}
resource "azurerm_storage_table" "example" {
    for_each = var.stg
  name                 = each.value.table_name
  storage_account_name = azurerm_storage_account.example[each.key].name
}