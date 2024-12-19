resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIP"
    public_ip_address_id = var.public_ip_id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_rule" "main" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
  probe_id                       = azurerm_lb_probe.main.id
}

output "lb_id" {
  value = azurerm_lb.main.id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.main.id
}

