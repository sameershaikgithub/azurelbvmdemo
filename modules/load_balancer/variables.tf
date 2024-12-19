variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for resources"
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "public_ip_id" {
  description = "The ID of the public IP address"
  type        = string
}

variable "vm_id" {
  description = "The ID of the VM to associate with the load balancer"
  type        = string
}

