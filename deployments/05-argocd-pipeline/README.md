## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.4 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| create_aks_cluster_argo | ./modules/clusters |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | The Azure Region | `string` | n/a | yes |
| suffix | This is a consolidated name based on org, environment, region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aks01\_cluster\_outputs | n/a |
