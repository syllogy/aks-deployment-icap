output "cluster_info_1" {
  value = azurerm_kubernetes_cluster.icap-deploy.name
}

output "cluster_info_2" {
  value = azurerm_kubernetes_cluster.icap-deploy.resource_group_name
}

output "cluster_endpoint" {
  value = data.azurerm_kubernetes_cluster.icap-deploy.endpoint
}

output "cluster_cert" {
  value = data.data.azurerm_kubernetes_cluster.icap-deploy.kube_config.0.client_certificate
}

output "cluster_token" {
  value = data.azurerm_kubernetes_cluster.icap-deploy.token
}