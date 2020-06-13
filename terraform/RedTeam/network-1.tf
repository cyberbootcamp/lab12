resource "azurerm_network_ddos_protection_plan" "redteam" {
  name                = format("%sddospplan1", var.resource_group_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_virtual_network" "redteam" {
  name                = format("%svirtualNetwork1",var.resource_group_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
  depends_on = [azurerm_network_ddos_protection_plan.redteam]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.redteam.id
    enable = false
  }

  tags = {
    environment = "Production"
  }
}

# Create subnet
resource "azurerm_subnet" "dmz" {
  name                 = "dmz"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.redteam.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [azurerm_virtual_network.redteam]
}

# Create subnet
resource "azurerm_subnet" "webtier" {
  name                 = "Web-Tier"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.redteam.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [azurerm_subnet.dmz]
}

# Create subnet
resource "azurerm_subnet" "apptier" {
  name                 = "apptier"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.redteam.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [azurerm_subnet.webtier]
}

resource "azurerm_subnet_network_security_group_association" "dmz" {
  subnet_id                 = azurerm_subnet.dmz.id
  network_security_group_id = azurerm_network_security_group.RedTeamSG1.id
  depends_on = [azurerm_subnet.apptier,azurerm_network_security_group.RedTeamSG1]
}

resource "azurerm_subnet_network_security_group_association" "webtier" {
  subnet_id                 = azurerm_subnet.webtier.id
  network_security_group_id = azurerm_network_security_group.RedTeamSG2.id
  depends_on = [azurerm_subnet_network_security_group_association.dmz,
    azurerm_network_security_group.RedTeamSG2]
}

resource "azurerm_subnet_network_security_group_association" "apptier" {
  subnet_id                 = azurerm_subnet.apptier.id
  network_security_group_id = azurerm_network_security_group.RedTeamSG3.id
  depends_on = [azurerm_subnet_network_security_group_association.webtier,
    azurerm_network_security_group.RedTeamSG3]
}

resource "azurerm_public_ip" "redteam-web" {
  name                = "nat-gateway-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "redteam-web" {
  name                = "nat-gateway-publicIPPrefix"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "redteam-web" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  public_ip_address_ids   = [azurerm_public_ip.redteam-web.id]
  public_ip_prefix_ids    = [azurerm_public_ip_prefix.redteam-web.id]
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  depends_on = [azurerm_public_ip.redteam-web,azurerm_public_ip_prefix.redteam-web]
}

resource "azurerm_subnet_nat_gateway_association" "redteam-web" {
  subnet_id      = azurerm_subnet.webtier.id
  nat_gateway_id = azurerm_nat_gateway.redteam-web.id
  depends_on = [azurerm_subnet.webtier,azurerm_nat_gateway.redteam-web]
}