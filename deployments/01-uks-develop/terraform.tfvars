azure_region           = "uksouth"
suffix                 = "dev"

domain                 = "cloudapp.azure.com"

icap_port              = 1344
icap_tlsport           = 1345

argocd_cluster_context = "argocd-aks-deploy"
enable_argocd_pipeline = true
enable_helm_deployment = false
revision               = "develop"