# Overview

This Terraform deployment will deploy the following resources:

- Storage Account
- Key vault
- Two AKS Clusters
- All charts needed for ICAP and File Drop Services via the Helm Provider
- ArgoCD cluster for managing pipeline (Optional as you can enable or disable)

## Table of contents

- [Overview](#overview)
  - [Table of contents](#table-of-contents)
  - [1. Quickstart guide](#1-quickstart-guide)
    - [1.1 Clone Repo.](#11-clone-repo)
    - [1.2 Edit terraform.tfvars](#12-edit-terraformtfvars)
    - [1.3 Change key in backend.tfvars](#13-change-key-in-backendtfvars)
    - [1.4 Init and Apply](#14-init-and-apply)
  - [2. Deployment and Code documentation](#2-deployment-and-code-documentation)
  - [2.1 Deployment Guide](#21-deployment-guide)
  - [2.2 Code Breakdown](#22-code-breakdown)
  - [3. ArgoCD](#3-argocd)
    - [3.1 Documentation](#31-documentation)


## 1. Quickstart guide

Below is a quick start guide so you can deploy a cluster to test with fairly quickly, without a ArgoCD pipeline. When you clone the repo down, you can you 01 - 03 deployments to stand up a cluster. 04 is for ArgoCD and should be left where it is.

### 1.1 Clone Repo.

```
git clone https://github.com/k8-proxy/icap-aks-delivery.git
cd icap-aks-delivery
git submodule init
git submodule update
```

### 1.2 Edit terraform.tfvars 

Open ```terraform.tfvars``` and change the suffix to something unique (not exceeding more than 5 chars) and make sure ```enable_argocd_pipeline``` is set to false and ```enable_helm_deployment``` is set to true.

```
azure_region           = "uksouth"
suffix                 = "qa"

domain                 = "cloudapp.azure.com"

icap_port              = 1344
icap_tlsport           = 1345

argocd_cluster_context = "argocd-aks-deploy"
enable_argocd_pipeline = false
enable_helm_deployment = true
revision               = "main"
```

### 1.3 Change key in backend.tfvars

You will also need to change to the key within the ```backend.tfvars``` as this will store you deployments state. The only part that needs to be unique is everything before ```.terraform.tfstate```

```
resource_group_name  = "gw-icap-tfstate"
storage_account_name = "tfstate263"
container_name       = "gw-icap-tfstate"
key                  = "03qauks.terraform.tfstate"
```

### 1.4 Init and Apply

Now you're ready to init and apply 

```
terraform init -backend-config="backend.tfvars"
```

```
terraform apply -var-file=terraform.tfvars
```

Once terraform has finished the ICAP and File Drop clusters, storage account, key vault and charts would have been deployed. The URLs for the services use the following naming convention:

```
icap-$SUFFIX.$REGION.cloudapp.azure.com

management-ui-$SUFFIX.$REGION.cloudapp.azure.com

file-drop-$SUFFIX.$REGION.cloudapp.azure.com
```

## 2. Deployment and Code documentation

## 2.1 Deployment Guide

For a more detailed guide please use the following README:

[Terraform-Guide](/documentation/Terraform/terraform-guide.md)

## 2.2 Code Breakdown

The following document covers some of the more custom code used in the deployment, I have not covered all code in this as most of the documentation can be found on the official Hashicorp website. To see the Code Breakdown use the following README:

[Code-Breakdown](/documentation/Terraform/code-breakdown.md)

## 3. ArgoCD

### 3.1 Documentation

For full documentation regarding using, deploying and installing ArgoCD please see the following documents:

[Installation-Guide](/documentation/Argocd/installation-guide.md)

[User Guide](documentation/Argocd/user-guide.md)

[Deployment-Guide](/documentation/Argocd/deployment-guide.md)
