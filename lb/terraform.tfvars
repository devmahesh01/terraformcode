lb = {
    mynewlb01 ={
        pip-name = "lb-pip"
        location = "central india"
        rg = "lb-rg"
       allocation_method = "Static"
       sku   = "Standard"
       pip-conf = "lbconf01"
      lb-backend_address_poolname = "lb-new-add-pool"
      pool-address-name = "backend_vm_01"
      pool-address-name = "backend_vm_02"
      probe-name = "lb-proble01"
      probeport = "80"
      rule-name = "lb-rule01"
      frontend_port = "80"
      backend_port ="80"
      











    }
}