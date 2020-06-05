#resource "azurerm_network_ddos_protection_plan" "example" {
#  name                = "ddospplan1"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetworkRedTeam1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
  depends_on = [azurerm_network_security_group.example]

#  ddos_protection_plan {
#    id     = azurerm_network_ddos_protection_plan.example.id
#    enable = true
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