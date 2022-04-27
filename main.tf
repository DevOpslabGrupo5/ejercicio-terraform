# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

}

provider "azurerm" {
  features {}
}

variable "name" {
}

variable "location" {
}

variable "appId" {
}

variable "password" {
}

resource "azurerm_resource_group" "grupo5" {
  name     = var.name
  location = var.location
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name                = "grupo5virtualnetwork"
  address_space       = ["12.0.0.0/16"]
  location            = azurerm_resource_group.grupo5.location
  resource_group_name = azurerm_resource_group.grupo5.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.grupo5.name
  virtual_network_name = azurerm_virtual_network.virtualnetwork.name
  address_prefixes     = ["12.0.0.0/20"]
}

resource "azurerm_kubernetes_cluster" "kubernetescluster" {
  name                = "aksdiplomado"
  location            = azurerm_resource_group.grupo5.location
  resource_group_name = azurerm_resource_group.grupo5.name
  dns_prefix          = "aks1"
  kubernetes_version  = "1.22.4"

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2ads_v5"
    node_count = 1
    vnet_subnet_id      = azurerm_subnet.subnet.id
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
  }
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  role_based_access_control_enabled = true

}