resource "azurerm_public_ip" "PublicIPForLB" {
  for_each = var.lb
  name                = each.value.pip-name
  location            = each.value.location
  resource_group_name = each.value.rg
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}
resource "azurerm_lb" "NginxLoadBalancer" {
  for_each = var.lb
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.rg
  sku                 = each.value.sku
  frontend_ip_configuration {
    name                 = each.value.pip-conf
    public_ip_address_id = azurerm_public_ip.PublicIPForLB[each.key].id
  }
}
resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
  for_each = var.lb
  loadbalancer_id = azurerm_lb.NginxLoadBalancer[each.key].id
  name            = each.value.lb-backend_address_poolname
}
resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  for_each = var.lb
  name                    = each.value.pool-address-name
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.example.id
  ip_address              = data.azurerm_virtual_machine.example.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  for_each = var.lb
  name                    = each.value.pool-address-name
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.example.id
  ip_address              = data.azurerm_virtual_machine.new01.private_ip_address
}
resource "azurerm_lb_probe" "nginxprobe" {
  for_each = var.lb
  loadbalancer_id = azurerm_lb.NginxLoadBalancer[each.key].id
  name            = each.value.probe-name
  port            = each.value.probeport
}
resource "azurerm_lb_rule" "example" {
  for_each = var.lb
  loadbalancer_id                = azurerm_lb.NginxLoadBalancer[each.key].id
  name                           = each.value.rule-name
  protocol                       = "Tcp"
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.pip-conf
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id]
  probe_id                       = azurerm_lb_probe.nginxprobe[each.key].id
}