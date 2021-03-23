## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| helm | n/a |
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) |
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| a\_record\_02 | A record for File-Drop | `string` | `""` | no |
| chart\_path01 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/filedrop"` | no |
| chart\_repo02 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/cert-manager-chart"` | no |
| chart\_repo03 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/ingress-nginx"` | no |
| cluster\_name | This is a consolidated name based on org, environment, region | `string` | `""` | no |
| file\_drop\_dns\_name\_01 | This is the DNS name for the ingress | `string` | `""` | no |
| namespace01 | This is the name of the namespace | `string` | `"icap-file-drop"` | no |
| namespace02 | This is the name of the namespace | `string` | `"cert-manager"` | no |
| namespace03 | This is the name of the namespace | `string` | `"ingress-nginx"` | no |
| node\_name | This is the resource group containing the Azure Key Vault | `string` | `"gwicapnode"` | no |
| region | The Azure Region | `string` | `""` | no |
| release\_name01 | This is the name of the release | `string` | `"file-drop"` | no |
| release\_name02 | This is the name of the release | `string` | `"cert-manager"` | no |
| release\_name03 | This is the name of the release | `string` | `"ingress-nginx"` | no |
| resource\_group | This is a consolidated name based on org, environment, region | `string` | `""` | no |

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
