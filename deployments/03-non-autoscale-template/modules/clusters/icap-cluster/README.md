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
| a\_record\_01 | A record for Management-UI | `string` | `""` | no |
| argocd\_cluster\_context | This is the argocd cluster name | `string` | `""` | no |
| chart\_path01 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/adaptation"` | no |
| chart\_path04 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/administration"` | no |
| chart\_path05 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/rabbitmq-operator"` | no |
| chart\_path06 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/ncfs"` | no |
| chart\_path07 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/elk-stack"` | no |
| chart\_path08 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/helm-charts/grafana"` | no |
| chart\_path09 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/helm-charts/prometheus"` | no |
| chart\_repo02 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/cert-manager-chart"` | no |
| chart\_repo03 | This is the path to the chart | `string` | `"../../charts/icap-infrastructure/ingress-nginx"` | no |
| cluster\_name | This is a consolidated name based on org, environment, region | `string` | `""` | no |
| dns\_name\_01 | DNS name for Icap-Service | `string` | `""` | no |
| dns\_name\_04 | DNS name for Management-UI | `string` | `""` | no |
| enable\_argocd\_pipeline | The bool to enable the Argocd pipeline | `bool` | `true` | no |
| icap\_port | Public port for the non-tls icap-service | `string` | `""` | no |
| icap\_tlsport | Public port for the tls icap-service | `string` | `""` | no |
| kv\_vault\_name | This is kv\_vault\_name | `string` | `""` | no |
| max\_count | This is the maximum node count for the autoscaler | `string` | `""` | no |
| min\_count | This is the minimum node count for the autoscaler | `string` | `""` | no |
| namespace01 | This is the name of the namespace | `string` | `"icap-adaptation"` | no |
| namespace02 | This is the name of the namespace | `string` | `"cert-manager"` | no |
| namespace03 | This is the name of the namespace | `string` | `"ingress-nginx"` | no |
| namespace04 | This is the name of the namespace | `string` | `"icap-administration"` | no |
| namespace05 | This is the name of the namespace | `string` | `"icap-rabbitmq-operator"` | no |
| namespace06 | This is the name of the namespace | `string` | `"icap-ncfs"` | no |
| namespace07 | This is the name of the namespace | `string` | `"icap-elk-stack"` | no |
| namespace08 | This is the name of the namespace | `string` | `"icap-central-monitoring"` | no |
| namespace09 | This is the name of the namespace | `string` | `"icap-central-monitoring"` | no |
| node\_name | This is the resource group containing the Azure Key Vault | `string` | `"gwicapnode"` | no |
| region | The Azure Region | `string` | `""` | no |
| release\_name01 | This is the name of the release | `string` | `"adaptation-service"` | no |
| release\_name02 | This is the name of the release | `string` | `"cert-manager"` | no |
| release\_name03 | This is the name of the release | `string` | `"ingress-nginx"` | no |
| release\_name04 | This is the name of the release | `string` | `"administration-service"` | no |
| release\_name05 | This is the name of the release | `string` | `"rabbitmq-operator"` | no |
| release\_name06 | This is the name of the release | `string` | `"icap-ncfs"` | no |
| release\_name07 | This is the name of the release | `string` | `"icap-elk-stack"` | no |
| release\_name08 | This is the name of the release | `string` | `"icap-grafana"` | no |
| release\_name09 | This is the name of the release | `string` | `"icap-prometheus"` | no |
| resource\_group | This is a consolidated name based on org, environment, region | `string` | `""` | no |
| revision | The revision/branch used for ArgoCD | `string` | `""` | no |
| storage\_resource | This is storage\_resource | `string` | `""` | no |
| suffix | This is a consolidated name based on org, environment, region | `string` | `""` | no |

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
