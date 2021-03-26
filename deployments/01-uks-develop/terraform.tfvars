azure_region           = "uksouth"
suffix                 = "mptest"

domain                 = "cloudapp.azure.com"

icap_port              = 1344
icap_tlsport           = 1345
ip_ranges_01           = "{212.59.65.150/32, 212.59.65.142/32}"

argocd_cluster_context = "argocd-aks-deploy"
enable_argocd_pipeline = true
enable_helm_deployment = false
revision               = "develop"

created_by             = "Matthew Pigram"
environment            = "Development"