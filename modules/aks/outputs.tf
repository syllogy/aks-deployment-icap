output "cluster_name" {
	value = "${azurerm_kubernetes_cluster.default.name}"
}

output "cluster_dns" {
	value = "${azurerm_kubernetes_cluster.default.dns_prefix}"
}

