
resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [var.network_interface_id]
  vm_size               = "Standard_B2s"

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data = file("web.conf")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

 storage_image_reference {
   publisher = "Canonical"
   offer     = "0001-com-ubuntu-server-focal"
   sku       = "20_04-lts-gen2"
   version   = "latest"
 }
}

