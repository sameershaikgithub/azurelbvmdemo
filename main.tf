provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  location            = var.location
  depends_on          = [module.resource_group]
}

module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  depends_on          = [module.resource_group, module.vnet]
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = var.resource_group_name
  nsg_name            = var.nsg_name
  location            = var.location
  depends_on          = [module.resource_group]
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  resource_group_name = var.resource_group_name
  lb_name             = var.lb_name
  location            = var.location
  public_ip_id        = module.public_ip.public_ip_id
  vm_id               = module.vm.vm_id
}

module "network_interface" {
  source              = "./modules/network_interface"
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.subnet_id
  nsg_id              = module.nsg.nsg_id
  location            = var.location
  vm_name             = var.vm_name
  backend_pool_id     = module.load_balancer.backend_pool_id # Added this to associate the NIC with the backend pool
  depends_on          = [module.resource_group, module.subnet, module.nsg]
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.subnet_id
  network_interface_id = module.network_interface.network_interface_id
  private_ip_address  = module.network_interface.private_ip_address
  vm_name             = var.vm_name
  nsg_id              = module.nsg.nsg_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  location            = var.location
  depends_on          = [module.resource_group, module.subnet, module.nsg, module.network_interface]
}

module "public_ip" {
  source              = "./modules/public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_ip_name      = "example-public-ip"
 depends_on          = [module.resource_group, module.subnet, module.nsg]
}

output "load_balancer_public_ip" {
  value = module.load_balancer.public_ip
}
