output "resource_group" {
	value = azurerm_kubernetes_cluster.file-drop.name
}

output "cluster_name" {
	value = azurerm_kubernetes_cluster.file-drop.name
}

output "cluster_dns" {
	value = azurerm_kubernetes_cluster.file-drop.dns_prefix
}

output "client_key" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config.0.client_key
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config.0.username
}

output "cluster_password" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config.0.password
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.file-drop.kube_config_raw
}