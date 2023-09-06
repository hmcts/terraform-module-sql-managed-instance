variable "admin_name" {
  type    = string
  default = "VMAdmin"

}

variable "env" {
  type    = string
  default = "sbox"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "builtFrom" {
  type    = string
  default = "hmcts/boostrap"
}

variable "product" {
  type    = string
  default = "martha"
}

variable "expiresAfter" {
  type    = string
  default = "0000-00-00"
}

variable "project" {
  type    = string
  default = "sds"
}

variable "component" {
  type    = string
  default = "data"
}

