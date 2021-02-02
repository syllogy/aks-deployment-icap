output "cluster_info_1" {
  value = data.azurerm_kubernetes_cluster.aks03-useast.name
}

output "cluster_info_2" {
  value = data.azurerm_kubernetes_cluster.aks03-useast.resource_group_name
}

output "cluster_endpoint" {
  value = data.azurerm_kubernetes_cluster.aks03-useast.kube_config.0.host
}

# output "cluster_cert" {
#   value = data.data.azurerm_kubernetes_cluster.aks03-useast.kube_config.0.client_certificate
# }

# output "cluster_token" {
#   value = data.azurerm_kubernetes_cluster.aks03-useast.token
# }