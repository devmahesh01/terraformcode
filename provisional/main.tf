
resource "azurerm_resource_group" "example" {
  name     = "prob-rg12"
  location = "West US"
}

resource "azurerm_virtual_network" "main" {
  name                = "shivvnet01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "shivsub01"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_public_ip" "example" {
  name                    = "test-pip"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  allocation_method       = "Static"
 idle_timeout_in_minutes = 30
}
   
 resource  "azurerm_network_security_group" "example" {
  name                = "mynsg02"
  location            = "West US"
  resource_group_name = "prob-rg12"
  dynamic "security_rule" {
    for_each = var.rule
    content  {
        name                   = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          =  security_rule.value.source_port_range 
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      =  "*"
    destination_address_prefix =  "*"
    }
    
}
 }

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_network_interface" "main" {
  name                = "shiv-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "shivip01"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "shivvm01"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "mu"
    admin_username = "azureadmin01"
    admin_password = "admin@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  connection {
    host = azurerm_public_ip.example.ip_address
    user = "azureadmin01"
    password = "admin@123456"
    type = "ssh"
    timeout = "2m"


  }

  provisioner "file" {
    source = "index.html"
    
  
  destination = "tmp/index.html"
  }
   
    
  provisioner "remote-exec" {
    inline = [ 
        "sudo apt update",
        "sudo apt install nginx -y",
        "cp tmp/index.html var/www/html",
        "sudo systemctl  restart nginx"
     ]

    
  }
  
  provisioner "local-exec" {
    command = "echo complete > complete.txt"
    
  }




  tags = {
    environment = "staging"
  }


 
}