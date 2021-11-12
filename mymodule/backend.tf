terraform {
    backend "azurerm" {
        resource_group_name = "tfstatestoragestg1"
        storage_account_name = "tfstatestorageus1"
        container_name = "tfstateprod1"
        key = "terraform.tfstateprod1"
        access_key = "ZPxpNfV6uBi7j7ZaccrTQcCJ2Zp5thorYu6cCcPmVH4wiRstYeMYorEScNiuLzLyAhfeHaweigYqANzj5b27Pw=="
      
    }

}