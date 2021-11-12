terraform {

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.46.0"
        }   
        
        }
}


resource "azurerm_subnet" "websubnet1" {
    name = "websubnet"
    resource_group_name = data.azurerm_resource_group.rg1.name
    virtual_network_name = data.azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.70.1.0/24" ]

  
}

resource "azurerm_subnet" "appsubnet1" {
    name = "appsubnet"
    resource_group_name = data.azurerm_resource_group.rg1.name
    virtual_network_name = data.azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.70.2.0/24" ]

  
}


resource "azurerm_subnet" "dbsubnet1" {
    name = "dbsubnet"
    resource_group_name = data.azurerm_resource_group.rg1.name
    virtual_network_name = data.azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.70.3.0/24" ]

  
}

# Public ip address for Web server
resource "azurerm_public_ip" "webpublicip1" {
    name = "webpublicip"
    resource_group_name = data.azurerm_resource_group.rg1.name
    location = data.azurerm_resource_group.rg1.location
    allocation_method = "Static"
  
}

# NIC for web server
resource "azurerm_network_interface" "webnic1" {
    name = "webnic"
    location = data.azurerm_resource_group.rg1.location
    resource_group_name = data.azurerm_resource_group.rg1.name
    ip_configuration {
      name = "public"
      subnet_id = azurerm_subnet.websubnet1.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.webpublicip1.id

    }
  
}

resource "azurerm_linux_virtual_machine" "webserver1" {
    name = "webserver"
    resource_group_name = data.azurerm_resource_group.rg1.name
    location = data.azurerm_resource_group.rg1.location
    size = "Standard_F2"
    admin_username = "adminuser"
    network_interface_ids = [ 
        azurerm_network_interface.webnic1.id 
        ]
    admin_ssh_key {
      username = "adminuser"
      public_key = file("~/.ssh/id_rsa.pub")
    }
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
    }
}


