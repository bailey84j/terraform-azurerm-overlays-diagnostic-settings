locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  diag_name           = coalesce(var.custom_diagnostic_setting_name, var.use_naming ? data.azurenoopsutils_resource_name.diagnostic_setting.result : data.azurenoopsutils_resource_name.diagnostic_setting.name)
}
