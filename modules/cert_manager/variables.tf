variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "enable_cert_manager" {
  type    = bool
  default = true
}

variable "cert_manager_version" {
  type    = string
  default = "v1.16.1"
}