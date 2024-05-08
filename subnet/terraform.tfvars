subs = {
    sub01 ={
        rg = "rg01"
        vnet = "vnet01"
        address_prefixes = ["192.168.1.0/24"]
    },
    sub02 ={
        rg = "rg01"
        vnet = "vnet01"
        address_prefixes = ["192.168.2.0/24"]
    },
    sub03 ={
        rg = "rg02"
        vnet = "vnet02"
        address_prefixes = ["10.0.2.0/24"]

    },
    AzureBastionSubnet ={
        rg = "rg02"
        vnet = "vnet02"
        address_prefixes = ["10.0.1.0/26"]
    },

}