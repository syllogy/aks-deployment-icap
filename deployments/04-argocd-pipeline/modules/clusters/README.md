## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| helm | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| chart\_path01 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/argocd"` | no |
| cluster\_name | This is a consolidated name based on org, environment, region | `string` | `""` | no |
| kv\_vault\_name | This is kv\_vault\_name | `string` | `""` | no |
| max\_count | This is the maximum node count for the autoscaler | `string` | `""` | no |
| min\_count | This is the minimum node count for the autoscaler | `string` | `""` | no |
| namespace01 | This is the name of the namespace | `string` | `"argocd"` | no |
| node\_name | This is the resource group containing the Azure Key Vault | `string` | `"gwicapnode"` | no |
| region | The Azure Region | `string` | `""` | no |
| release\_name01 | This is the name of the release | `string` | `"argocd"` | no |
| resource\_group | This is a consolidated name based on org, environment, region | `string` | `""` | no |
| storage\_resource | This is storage\_resource | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| client\_certificate | n/a |
| client\_key | n/a |
| cluster\_ca\_certificate | n/a |
| cluster\_dns | n/a |
| cluster\_name | n/a |
| cluster\_password | n/a |
| cluster\_username | n/a |
| kube\_config | n/a |
| resource\_group | n/a |
