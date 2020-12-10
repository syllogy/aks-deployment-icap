# Azure Key Vault Creation

The modules will create the 

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.35.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | Metadata Azure Region | `string` | n/a | yes |
| resource\_group | The Azure Region | `string` | n/a | yes |
| kv\_name | The name of the key vault | `string` | n/a | yes |