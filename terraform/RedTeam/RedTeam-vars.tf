variable "resource_group_name" {
  default = "Red-Team"
}
variable "location" {
  default = "westus2"
}

variable "machine1_size" {
  default = "Standard_B1s"
}
variable "machine1_name" {
  default = "Jump-Box-Provisioner"
}
variable "machine1_osdisk_type" {
  default = "Premium_LRS"
}
variable "machine1_adminusername" {
  default = "RedAdmin"
}
variable "machine1_publickey" {
  #default = file("${path.module}/hello.txt")"file(${HOME}/.ssh/id_rsa.pub)"
}

variable "machine2_size" {
  default = "Standard_B1s"
}

variable "machine2_name" {
  default = "DVWA-VM1"
}

variable "machine2_osdisk_type" {
  default = "Premium_LRS"
}
variable "machine2_adminusername" {
  default = "RedAdmin"
}
variable "machine2_publickey" {}
#variable "machine2_custom_data" {}

variable "my_ip_address" {}

output "my_ip_address" {
  value = "${var.my_ip_address}"
}