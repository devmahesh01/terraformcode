vnet = {
    vnet01 = {
        location ="west us"
        resource_group_name = "rg26"
        address_space = ["192.168.0.0/16"]
        dns_servers = ["192.168.0.4" , "192.168.0.5"]

    }
}
subs = {
    sub01 ={
        name = "new-sub-01"
        address_prefix = "192.168.1.0/24"
        security_group = "mynsg01"
    },
    sub01 ={
        name = "new-sub-02"
        address_prefix = "192.168.2.0/24"
       
    }

}