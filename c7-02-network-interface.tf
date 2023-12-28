resource "azurerm_network_interface" "windows_nic" {
    for_each = var.web_windows_instance_count
    name = "${local.resource_name_prefix}-windows-nic-${each.key}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name = "web_nic-${each.key}"
        subnet_id = azurerm_subnet.websubnet.id 
        private_ip_address_allocation = "Dynamic"
        }
}