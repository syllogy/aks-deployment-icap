# Auto-scale Template

This template deploys a four node cluster, with autoscaling set to the following:

- Minimum - 4 nodes
- Maximum - 100 nodes

This is to be used for load testing and performance testing. Please do not use this deployment for small code change testing.

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.4 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| create_aks_cluster | ./modules/clusters/icap-cluster |  |
| create_aks_cluster_file_drop | ./modules/clusters/file-drop-cluster |  |
| create_key_vault | ./modules/keyvault |  |
| create_storage_account | ./modules/storage-account |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| argocd\_cluster\_context | The Argocd context name for use with the Argocd CLI | `string` | n/a | yes |
| azure\_region | The Azure Region | `string` | n/a | yes |
| domain | This is a domain of organization | `string` | n/a | yes |
| enable\_argocd\_pipeline | The bool to enable the Argocd pipeline | `bool` | `true` | no |
| enable\_helm\_deployment | The bool to enable the helm deployment | `bool` | `true` | no |
| icap\_port | The Azure backend vault name | `string` | n/a | yes |
| icap\_tlsport | The Azure backend storage account | `string` | n/a | yes |
| ip\_ranges\_01 | Whitelisted IP Ranges | `string` | `""` | no |
| revision | The revision/branch used for ArgoCD | `string` | n/a | yes |
| suffix | This is a consolidated name based on org, environment, region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aks01\_cluster\_outputs | n/a |
| file\_drop\_cluster\_outputs | n/a |
| storage\_acccount\_outputs | n/a |
