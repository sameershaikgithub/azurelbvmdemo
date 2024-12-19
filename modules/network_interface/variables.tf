variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for resources"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the network interface"
  type        = string
}

variable "nsg_id" {
  description = "The ID of the network security group"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "backend_pool_id" {
  description = "The ID of the Load Balancer backend pool"
  type        = string
}

