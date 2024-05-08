variable "rg" {
    type = map(object({
      location = string
      tags= optional(map(string))
    }))
  
}