resource "azurerm_resource_group" "rg" {
  name     = upper(var.resource_group_name)
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = upper(var.vnet_name)
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
  for_each                        = var.subnets
  name                            = upper(each.key)
  resource_group_name             = azurerm_resource_group.rg.name
  virtual_network_name            = azurerm_virtual_network.vnet.name
  address_prefixes                = each.value.address_prefixes
  default_outbound_access_enabled = false
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnets
  name                = upper("nsg-${each.key}")
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}