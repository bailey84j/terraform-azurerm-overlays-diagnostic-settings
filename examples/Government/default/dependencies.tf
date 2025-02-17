# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_resource_group" "diagnostic-settings-network-rg" {
  name     = "diagnostic-settings-network-rg"
  location = var.location
  tags = {
    environment = "test"
  }
}

resource "azurerm_virtual_network" "diagnostic-settings-vnet" {
  depends_on = [
    azurerm_resource_group.diagnostic-settings-network-rg
  ]
  name                = "diagnostic-settings-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.diagnostic-settings-network-rg.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_subnet" "diagnostic-settings-snet" {
  depends_on = [
    azurerm_resource_group.diagnostic-settings-network-rg,
    azurerm_virtual_network.diagnostic-settings-vnet
  ]
  name                 = "diagnostic-settings-subnet"
  resource_group_name  = azurerm_resource_group.diagnostic-settings-network-rg.name
  virtual_network_name = azurerm_virtual_network.diagnostic-settings-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "diagnostic-settings-nsg" {
  depends_on = [
    azurerm_resource_group.diagnostic-settings-network-rg,
  ]
  name                = "diagnostic-settings-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.diagnostic-settings-network-rg.name
  tags = {
    environment = "test"
  }
}

resource "azurerm_log_analytics_workspace" "diagnostic-settings-log" {
  depends_on = [
    azurerm_resource_group.diagnostic-settings-network-rg
  ]
  name                = "diagnostic-settings-log"
  location            = var.location
  resource_group_name = azurerm_resource_group.diagnostic-settings-network-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = "test"
  }
}

resource "azurerm_key_vault" "diagnostic-settings-kv" {
  depends_on = [
    azurerm_resource_group.diagnostic-settings-network-rg
  ]
  name                = "diagnostic-settings-kv"
  location            = var.location
  resource_group_name = azurerm_resource_group.diagnostic-settings-network-rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags = {
    environment = "test"
  }
}
