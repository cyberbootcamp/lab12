resource "azurerm_public_ip" "rt" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "rt" {
  name                = "RedTeamLoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.rt.id
  }
}

resource "azurerm_lb_probe" "rt" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.rt.id
  name                = "http-running-probe"
  port                = 80
}

resource "azurerm_lb_backend_address_pool" "rt" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.rt.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_rule" "rt" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.rt.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = azurerm_lb_probe.rt.port
  #frontend_ip_configuration_name = azurerm_lb.rt.frontend_ip_configuration[0].name
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id = "${azurerm_lb_probe.rt.id}"
}

resource "azurerm_network_interface_backend_address_pool_association" "pool1" {
  network_interface_id    = azurerm_network_interface.redteam-vm2-nic.id
  ip_configuration_name   = "vm2NicConfiguration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.rt.id
}

output "lbfqdn" {
  value = "${azurerm_public_ip.rt.fqdn}"
}

output "lbip" {
  value = "${azurerm_public_ip.rt.ip_address}"
}