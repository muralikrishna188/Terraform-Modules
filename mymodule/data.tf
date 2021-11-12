data "azurerm_resource_group" "rg1" {
    name = "prodapacrg"
  
}

data "azurerm_virtual_network" "vnet1" {
    name = "prodapacvnet"
    resource_group_name = data.azurerm_resource_group.rg1.name
  
}
