variable "resource_group_name" {}
variable "location" {}

variable "machine1_size" {}
variable "machine1_name" {}
variable "machine1_osdisk_type" {}
variable "machine1_adminusername" {}
variable "machine1_publickey" {}
#variable "machine1_custom_data" {}

variable "machine2_size" {}
variable "machine2_name" {}
variable "machine2_osdisk_type" {}
variable "machine2_adminusername" {}
variable "machine2_publickey" {}
#variable "machine2_custom_data" {}

variable "my_ip_address" {}

output "my_ip_address" {
  value = "${var.my_ip_address}"
}