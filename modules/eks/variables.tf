variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "is_eks_cluster_enabled" {
  type = bool
}

variable "cluster_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "addons" {
  type = list(object({
    name = string
    version = string
  }))
}

variable "ondemand_instance_type" {
  type = list(string)
}

variable "spot_instance_type" {
  type = list(string)
}
variable "desired_capacity_on_demand" {
  type = number
}

variable "max_capacity_on_demand" {
  type = number
}

variable "min_capacity_on_demand" {
  type = number
}

variable "desired_capacity_on_spot" {
  type = number
}

variable "max_capacity_on_spot" {
  type = number
}

variable "min_capacity_on_spot" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "eks_cluster_role_arn" {
  type = string  
}

variable "eks_node_role_arn" {
  type = string
}

variable "authentication_mode" {
  type = string
}

