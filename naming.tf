# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#------------------------------------------------------------
# Azure NoOps Naming - This should be used on all resource naming
#------------------------------------------------------------
data "azurenoopsutils_resource_name" "diagnostic_setting" {
  name          = var.workload_name
  resource_type = "azurerm_monitor_diagnostic_setting"
  prefixes      = [module.org_name.name, var.use_location_short_name ? module.mod_azure_region_lookup.location_short : var.location]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.environment, local.name_suffix, var.use_naming ? "" : "diagsetting"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}
