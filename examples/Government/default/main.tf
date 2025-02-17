# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_diagnostic_settings" {
  #source  = "azurenoops/overlays-diagnostic-settings/azurerm"
  #version = "x.x.x"
  source = "../../.."

  # Resource Group, location, VNet and Subnet details
  location           = var.location
  deploy_environment = var.deploy_environment
  environment        = var.environment
  org_name           = module.org_name.name

  resource_id           = azurerm_key_vault.diagnostic-settings-kv.id
  logs_destinations_ids = [azurerm_log_analytics_workspace.diagnostic-settings-log.id]
}
