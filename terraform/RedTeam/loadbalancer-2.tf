resource "azurerm_public_ip" "rt" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_frontdoor" "fd1" {
  enforce_backend_pools_certificate_name_check = false
  name = "ReadTeamFrontDoor"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = ["azurerm_lb.rt"]

  backend_pool {
    health_probe_name = azurerm_lb_probe.rt.name
    load_balancing_name = azurerm_lb.rt.name
    name = "BackendPool1"
    backend {
      address = azurerm_public_ip.rt.ip_address
      host_header = azurerm_public_ip.rt.
      http_port = 80
      https_port = 443
    }
  }
  backend_pool_health_probe {
    name = "http-running-probe"
  }
  backend_pool_load_balancing {
    name = "RedTeamLoadBalancer"
  }
  frontend_endpoint {
    custom_https_provisioning_enabled = false
    host_name = "www.redteam.io"
    name = "RedTeamFEndpoint"
  }
  routing_rule {
    accepted_protocols = ["Http","Https"]
    frontend_endpoints = ["RedTeamFEndpoint"]
    name = azurerm_lb_rule.rt-rule1.name
    patterns_to_match = ["/*"]
    forwarding_configuration {
      backend_pool_name = azurerm_lb_backend_address_pool.rt.name
    }
  }
}
resource "azurerm_lb" "rt" {
  name                = "RedTeamLoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [azurerm_public_ip.rt]

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
  depends_on = [azurerm_lb.rt]
}

resource "azurerm_lb_backend_address_pool" "rt" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.rt.id
  name                = "BackEndAddressPool"
  depends_on = [azurerm_lb.rt]
}

resource "azurerm_lb_rule" "rt-rule1" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.rt.id
  name                           = "LBRule1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = azurerm_lb_probe.rt.port
  #frontend_ip_configuration_name = azurerm_lb.rt.frontend_ip_configuration[0].name
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.rt.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.rt.id
  depends_on = [azurerm_lb.rt,azurerm_lb_probe.rt]
}

#resource "azurerm_lb_rule" "rt-rule2" {
#  resource_group_name            = azurerm_resource_group.rg.name
#  loadbalancer_id                = azurerm_lb.rt.id
#  name                           = "LBRule2"
#  protocol                       = "Tcp"
#  frontend_port                  = 443
#  backend_port                   = azurerm_lb_probe.rt.port
#  #frontend_ip_configuration_name = azurerm_lb.rt.frontend_ip_configuration[0].name
#  frontend_ip_configuration_name = "PublicIPAddress"
#  probe_id                       = azurerm_lb_probe.rt.id
#  backend_address_pool_id        = azurerm_lb_backend_address_pool.rt.id
#  depends_on = [azurerm_lb.rt,azurerm_lb_probe.rt]
#}

resource "azurerm_network_interface_backend_address_pool_association" "pool1" {
  network_interface_id    = azurerm_network_interface.redteam-vm2-nic.id
  ip_configuration_name   = "vm2NicConfiguration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.rt.id
  depends_on = [azurerm_network_interface.redteam-vm2-nic,azurerm_lb_backend_address_pool.rt]
}

#output "lbfqdn" {
#  value = "${azurerm_public_ip.rt.fqdn}"
#}

output "lbip" {
  value = "${azurerm_public_ip.rt.ip_address}"
}