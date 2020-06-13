resource "azurerm_network_security_group" "RedTeamSG2" {
  name                = format("%sSecurityGroup2", var.resource_group_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name = "Allow-81TCP"
    priority = 4091
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "*"
    destination_port_range = "81"
    source_address_prefix = "*" # ar.my_ip_address
    destination_address_prefix = "*"
    description = "Allow Web traffic."
  }

  security_rule {
    name = "Allow-80TCP"
    priority = 4092
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*" # ar.my_ip_address
    destination_address_prefix = "*"
    description = "Allow Web traffic."
  }

  security_rule {
    name                       = "Allow-SSH-on-VNet2"
    priority                   = 4093
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"
    description = "Allow SSH traffic."
  }

  security_rule {
    name                       = "Allow-SSH-on-VNet"
    priority                   = 4094
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    description = "Allow SSH traffic."
  }

  security_rule {
    name                       = "Default-Deny"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description = "Deny all inbound traffic."
  }
}