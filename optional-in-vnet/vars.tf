variable "vnet" {
    type = map(any)

  
}
variable "subs" {
    default = null
    type = map(object({
      name = string
      address_prefix = string
      security_group = optional(string)
    }))
  
}