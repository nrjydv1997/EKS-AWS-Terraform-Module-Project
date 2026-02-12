variable "enable_nginx_ingress" {
  type    = bool
  default = true
}

variable "nginx_ingress_version" {
  type    = string
  default = "4.11.3"
}

variable "region" {
  type = string
}