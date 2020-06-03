resource "azurerm_network_ddos_protection_plan" "example" {
  name                = "ddospplan1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "deny_rdp"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    description = "Blocks RDP from any source over port TCP/3389"
  }

}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetworkRedTeam1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }

#  subnet {
#    address_prefix = "10.0.0.0/24"
#    name = "webtier"
#    security_group = azurerm_network_security_group.RedTeamSG.id
#  }

#  subnet {
#    name           = "accounting"
#    address_prefix = "10.0.1.0/24"
#  }

#  subnet {
#    name           = "human_resources"
#    address_prefix = "10.0.2.0/24"
#    security_group = azurerm_network_security_group.example.id
#  }

#  subnet {
#    name           = "finance"
#    address_prefix = "10.0.3.0/24"
#    security_group = azurerm_network_security_group.example.id
#  }

  tags = {
    environment = "Production"
  }
}