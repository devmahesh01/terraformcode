locals {
  rg_prefix = "rg_devinsider-"
  tags = {
    environment = "production"
    managedby =  "mahesh"
  }
}




resource "azurerm_resource_group" "new" {
    for_each = var.rg
  name     = "${local.rg_prefix}${each.key}"
  location = each.value.location
  tags = local.tags
}