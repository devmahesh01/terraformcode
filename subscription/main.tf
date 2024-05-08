resource "azurerm_subscription" "example" {
    for_each = var.subs
  alias             = each.value.alias
  subscription_name = each.key
  subscription_id   = each.value.subscription_id
}