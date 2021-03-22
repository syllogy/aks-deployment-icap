## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) |
| [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| file\_drop\_dns | Name of the common name used for the certs | `string` | `""` | no |
| icap\_dns | Name of the common name used for the certs | `string` | `""` | no |
| kv\_name | The name of the key vault | `string` | `""` | no |
| mgmt\_dns | Name of the common name used for the certs | `string` | `""` | no |
| region | Metadata Azure Region | `string` | `""` | no |
| resource\_group | Azure Resource Group | `string` | `""` | no |

## Outputs

No output.
