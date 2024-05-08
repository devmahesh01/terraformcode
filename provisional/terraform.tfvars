rule = {
  rule01= {

        name                   = "sshrule"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          =  "*"
    
    destination_port_range     = "22"
    source_address_prefix      =  "*"
    destination_address_prefix =  "*"
  },
   rule01= {
  name                   = "httprule"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          =  "*"
    
    destination_port_range     = "80"
    source_address_prefix      =  "*"
    destination_address_prefix =  "*"
  },
   rule01= {

        name                   = "outrule"
    priority                   = "1001"
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          =  "*"
    
    destination_port_range     = "80"
    source_address_prefix      =  "*"
    destination_address_prefix =  "*"
  },








} 