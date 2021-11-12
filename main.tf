terraform {
    backend "azurerm" {
        resource_group_name = "tfstatestoragestg1"
        storage_account_name = "tfstatestorageus1"
        container_name = "tfstateprod2"
        key = "terraform.tfstateprod2"
        access_key = "ZPxpNfV6uBi7j7ZaccrTQcCJ2Zp5thorYu6cCcPmVH4wiRstYeMYorEScNiuLzLyAhfeHaweigYqANzj5b27Pw=="
      
    }
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.46.0"
        }   
        
        }
}

variable subscription_id {
    type = string
    default = "049cc0b9-2696-4e70-871b-4366be487c19"
    description = "dev subscription"
  
}

variable client_id {
    type = string
    default = "5a3f94a8-760c-4667-9aad-8d7552b76ed0"
    description = "dev client"
  
}

variable client_secret {
    type = string
    default = "uDC7Q~XvUsyS5wPpf3JRWZVT7_zvxHIF0Md_Z"
    description = "dev client secret"
  
}

variable tenant_id {
    type = string
    default = "477cf0a5-266c-4331-8f0a-865f4622d888"
  
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
}

locals {
  setup_name = "practice-chennai"
}
data "azurerm_resource_group" "rg1" {
    name = "prodapacrg"
  
}

resource "azurerm_app_service_plan" "appplan" {
    name = "appplandev"
    location = data.azurerm_resource_group.rg1.location
    resource_group_name = data.azurerm_resource_group.rg1.name
    sku {
        tier = "standard"
        size = "S1"
    }
    depends_on = [data.azurerm_resource_group.rg1]
    tags = {
        name = "${local.setup_name}-appplan"
    }
}

resource "azurerm_app_service" "webapp" {
    name = "webappdev2345"
    location = data.azurerm_resource_group.rg1.location
    resource_group_name = data.azurerm_resource_group.rg1.name
    app_service_plan_id = azurerm_app_service_plan.appplan.id
    depends_on = [
        azurerm_app_service_plan.appplan
    ]
    tags = {
        name = "${local.setup_name}-webapp"
    }
}

