resource "azurerm_public_ip" "redteamip" {
  name                = format("%sJumpboxPublicIp1", var.resource_group_name)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}