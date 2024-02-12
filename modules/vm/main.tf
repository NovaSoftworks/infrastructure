locals {
  component = "novacp-${var.environment}-${var.region_short}-vm-${var.vm_name}"
}

resource "azurerm_resource_group" "vm_rg" {
  name     = "${local.component}-rg"
  location = var.region
}

# Public IP
resource "azurerm_public_ip" "vm_publicip" {
  name                = "${local.component}-publicip"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location
  allocation_method   = "Dynamic"
}

# Network interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "${local.component}-nic"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = azurerm_resource_group.vm_rg.location

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_publicip.id
  }
}

# Virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = local.component
  resource_group_name             = azurerm_resource_group.vm_rg.name
  location                        = azurerm_resource_group.vm_rg.location
  size                            = var.vm_size
  computer_name                   = var.vm_name
  disable_password_authentication = false
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    name                 = "${local.component}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
