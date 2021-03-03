output "aks01_cluster_outputs" {
	value 	  = module.create_aks_cluster
}

output "storage_acccount_outputs" {
	value 	  = module.create_storage_account
}

output "file_drop_cluster_outputs" {
	value     = module.create_aks_cluster_file_drop
}