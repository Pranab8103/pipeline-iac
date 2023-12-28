resource "azurerm_subnet" "bastion_subnet" {
  name = var.bastion_service_subnet_name
  resource_group_name = azurerm_resource_group.rg.name 
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = var.bastion_service_address_prefixes
}

resource "azurerm_public_ip" "bastion-ip" {
    name = "bastion-public-ip"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "Azure-Bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "bastion-ip-configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id 
    public_ip_address_id = azurerm_public_ip.bastion-ip.id
  }
}