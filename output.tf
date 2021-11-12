output "virtual_network_id" {
    value = data.azurerm_virtual_network.vnet1.id
}

output "vnet_address_space" {
    value = data.azurerm_virtual_network.vnet1.address_space
}

output "subnet_id" {
    value = azurerm_subnet.websubnet1.id
}