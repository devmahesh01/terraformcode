vnet = {
    vnet01 = {
        location = "westus"
        rg = "rg01"
        address_space = ["192.168.0.0/16"]
        dns_servers = ["192.168.0.4","192.168.0.5"]


    },
    vnet02 = {
    location = "centralindia"
        rg = "rg02"
        address_space = ["10.0.0.0/16"]
        dns_servers = ["10.0.0.4","10.0.0.5"]
}
}