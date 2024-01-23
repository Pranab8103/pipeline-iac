#Meta-Argument count - Terraform Function element()
#Meta-Argument for-each - Terraform function lookups()
#element([1,2,3], 0) -> 1
#element([1,2,3], 1) -> 2
#element
resource "azurerm_windows_virtual_machine" "vm" {
    for_each = var.web_windows_instance_count
    name                = "${local.resource_name_prefix}-web-windows-${each.key}"
    resource_group_name = azurerm_resource_group.rg.name 
    location            = azurerm_resource_group.rg.location
    computer_name = "windows-vm-${each.key}"
    size                = "Standard_B1s"
    admin_username      = "adminuser"
    admin_password      = "Azure@123"
    network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]

    os_disk {
        name = "${local.resource_name_prefix}-web-linuxvm-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer" 
        sku       = "2016-Datacenter"
        version   = "latest"
    } 
}
