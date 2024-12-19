variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "nsg_id" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "location" {
  type = string
}

variable "network_interface_id" {
  description = "The ID of the network interface to attach to the virtual machine"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address of the network interface"
  type        = string
}
