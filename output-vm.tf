/*
output "nic-output" {
    description = "Tuple of 5 metwork interface"
    value = azurerm_network_interface.windows_nic[*].id
}

output "windows-VM-output" {
    description = "Tuple of 5 VM"
    value = azurerm_windows_virtual_machine.vm[*].network_interface_ids
}
output "windows-vm-id" {
    description = "VM id"
    value = azurerm_windows_virtual_machine.vm[*].id
}*/