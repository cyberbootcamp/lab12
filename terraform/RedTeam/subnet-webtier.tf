

resource "azurerm_network_security_group" "RedTeamSG" {
  name                = "RedTeamSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #depends_on = [azurerm_resource_group.rg]

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


  security_rule {
    name = "Allow-80TCP"
    priority = 4093
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "${var.my_ip_address}"
    destination_address_prefix = "*"
    description = "Allow Web traffic."
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.my_ip_address}"
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

}

# Create subnet
resource "azurerm_subnet" "webtier" {
  name                 = "Web-Tier"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.0.0/24"
  depends_on = [azurerm_network_security_group.example]
}