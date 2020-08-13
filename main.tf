provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.23.0"
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "resource-group" {
  name = "balajiTWResourceGrp"
  location = "Central US"
}


resource "azurerm_storage_account" "storage-account" {
  name = "balajitwstorage"
  resource_group_name = azurerm_resource_group.resource-group.name
  location = azurerm_resource_group.resource-group.location
  account_tier = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_app_service_plan" "service-plan" {
  name = "azure-functions-test-service-plan"
  location = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name
  kind = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "function-app" {
  name = "balaji-tw-azure-test"
  location = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  storage_account_name       = azurerm_storage_account.storage-account.name
  storage_account_access_key = azurerm_storage_account.storage-account.primary_access_key
  version = "~2"
  app_settings = {
    FUNCTION_APP_EDIT_MODE = "readOnly"
    WEBSITE_RUN_FROM_PACKAGE = 1
    FUNCTIONS_WORKER_RUNTIME = "java"
    SCM_DO_BUILD_DURING_DEPLOYMENT = false
    FUNCTIONS_WORKER_RUNTIME_VERSION = 1.8
  }
}
