# ARC Creation

This will create an ACR within Azure - this isn't used in the current Terraform deployment due to use of Dockerhub. In future we can use an ACR seperate images from each other to ensure each environment is isolated.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.35.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.35.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| region | The Azure Region | `string` | n/a | yes |
| account\_tier | The Storage Account tier | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acr\_name | n/a |
| acr\_id | n/a |