## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) |
| [azurerm_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_tier | The Storage Account replication type | `string` | `"Hot"` | no |
| account\_kind | The kind of the storage account (cool, hot, archive) | `string` | `"FileStorage"` | no |
| account\_tier | The tier of storage account | `string` | `"Premium"` | no |
| application\_replication\_type | The Storage Account replication type | `string` | `"LRS"` | no |
| file\_share\_name01 | The name of the file share | `string` | `"transactions"` | no |
| file\_share\_name02 | The name of the file share | `string` | `"policies"` | no |
| region | The Azure Region/location the resource will be installed | `string` | `""` | no |
| resource\_group | This is a consolidated name based on org, environment, region | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | n/a |
| resource\_group\_name | n/a |
