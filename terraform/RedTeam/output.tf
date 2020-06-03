output "identity" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.identity}"
}

output "private_ip_address" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.private_ip_address}"
}

output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.public_ip_address}"
}

output "admin_username" {
  value = "${azurerm_linux_virtual_machine.redteam-vm1.admin_username}"
}