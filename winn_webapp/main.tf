resource "azurerm_service_plan" "example" {
    for_each = var.webapp
  name                = each.value.webplan_name
  resource_group_name = each.value.rg
  location            = each.value.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_windows_web_app" "example" {
    for_each = var.webapp
  name                = each.key
  resource_group_name = each.value.rg
  location            = each.value.location
  service_plan_id     = azurerm_service_plan.example[each.key].id

  site_config {}
}