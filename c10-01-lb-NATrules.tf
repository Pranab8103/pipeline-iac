#Resource : Azure LB NAT rule 
resource "azurerm_lb_nat_rule" "web_lb_inbound_nat_rule_22" {
    depends_on = [ azurerm_windows_virtual_machine.vm ]
    for_each = var.web_windows_instance_count
    name = "${each.key}-${each.value}-vm-22"
    protocol = "Tcp"
    frontend_port = each.value
    #frontend_port = elememt(var.lb_inbound_nat_ports, count.index) 

    backend_port = 22
    frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
    resource_group_name = azurerm_resource_group.rg.name 
    loadbalancer_id = azurerm_lb.web_lb.id 
}

resource "azurerm_network_interface_nat_rule_association" "web_nic_nat_rule_association" {
    for_each = var.web_windows_instance_count
    network_interface_id = azurerm_network_interface.windows_nic[each.key].id
    ip_configuration_name =  azurerm_network_interface.windows_nic[each.key].ip_configuration[0].name
    nat_rule_id = azurerm_lb_nat_rule.web_lb_inbound_nat_rule_22[each.key].id
}