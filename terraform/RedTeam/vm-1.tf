
# Create network interface
resource "azurerm_network_interface" "redteam-vm1-nic" {
  name                      = format("%svm1NIC", var.resource_group_name)
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  internal_dns_name_label   = "jumpbox"
  depends_on = [azurerm_public_ip.redteamip,azurerm_resource_group.rg]

  ip_configuration {
    name                          = format("%svm1NicConfiguration", var.resource_group_name)
    subnet_id                     = azurerm_subnet.dmz.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.redteamip.id

  }

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_network_interface_security_group_association" "redteam-vm1" {
  network_interface_id      = azurerm_network_interface.redteam-vm1-nic.id
  network_security_group_id = azurerm_network_security_group.RedTeamSG1.id
  depends_on = [azurerm_network_interface.redteam-vm1-nic]
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "redteam-vm1" {
  name                  = format("%s-%s", var.resource_group_name,var.machine1_name)
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.redteam-vm1-nic.id]
  size                  = var.machine1_size
  custom_data           = filebase64("cloud-init-1.txt")

  os_disk {
    name              = format("%s-%s-%s", var.resource_group_name,var.machine1_name,"machine1-OsDisk")
    caching           = "ReadWrite"
    storage_account_type = var.machine1_osdisk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = var.machine1_name
  admin_username = var.machine1_adminusername
  disable_password_authentication = true

  admin_ssh_key {
    username       = var.machine1_adminusername
    public_key     = file("/home/kali/.ssh/id_rsa.pub")
  }
  depends_on = [azurerm_network_interface_security_group_association.redteam-vm1]

#  boot_diagnostics {
#    storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
#  }

  tags = {
    environment = "Terraform Demo"
  }
}

output "identity" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.identity}"
  depends_on = [azurerm_linux_virtual_machine.redteam-vm1]
}

output "private_ip_address" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.private_ip_address}"
  depends_on = [azurerm_linux_virtual_machine.redteam-vm1]
}

output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.public_ip_address}"
  depends_on = [azurerm_linux_virtual_machine.redteam-vm1]
}

output "admin_username" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.admin_username}"
  depends_on = [azurerm_linux_virtual_machine.redteam-vm1]
}