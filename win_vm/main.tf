resource "azurerm_network_interface" "example" {
    for_each = var.vm
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.rg

  ip_configuration {
    name                          = each.value.conf_name
    subnet_id                     = data.azurerm_subnet.example[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_public_ip" "example" {
    for_each = var.vm
  name                = each.value.pip
  resource_group_name = each.value.rg
  location            = each.value.location
  allocation_method   = "Static"
}

resource "azurerm_windows_virtual_machine" "example" {
    for_each = var.vm
  name                = each.key
  resource_group_name = each.value.rg
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.adminname
  admin_password      = each.value.adminpassword
  network_interface_ids = [
    azurerm_network_interface.example[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = each.value.stg_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = each.value.sku
    version   = "latest"
  }
}