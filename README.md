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
  - [Prerequisites](#prerequisites)
  - [1. Quickstart guide](#1-quickstart-guide)
    - [Clone the repo](#clone-the-repo)
    - [1.2 Start Docker Container](#12-start-docker-container)
    - [1.2 Change Icap-infrastructure branch](#12-change-icap-infrastructure-branch)
    - [1.2 Log in to Azure CLI](#12-log-in-to-azure-cli)
    - [1.3 Edit terraform.tfvars](#13-edit-terraformtfvars)
    - [1.4 Change key in backend.tfvars](#14-change-key-in-backendtfvars)
    - [1.5 Init and Apply](#15-init-and-apply)
    - [1.6 Destroying the deployment](#16-destroying-the-deployment)
  - [2. Deployment and Code documentation](#2-deployment-and-code-documentation)
  - [2.1 Deployment Guide](#21-deployment-guide)
  - [2.2 Code Breakdown](#22-code-breakdown)
  - [3. ArgoCD](#3-argocd)
    - [3.1 Documentation](#31-documentation)

## Prerequisites

For all pre-reqs please see full guide below:

[Terraform-Guide](/documentation/Terraform/terraform-guide.md)

## 1. Quickstart guide

Below is a quick start guide so you can deploy a cluster to test with fairly quickly, without a ArgoCD pipeline. When you clone the repo down, you can use 01 - 04 deployments to stand up a cluster. 04 is for ArgoCD and should be left where it is.

### Clone the repo

For now this step is here so you can access the Dockerfile. Once the container is in our Dockerhub account it will be removed.

```bash
git clone https://github.com/filetrust/aks-deployment-icap.git
```

### 1.2 Start Docker Container

To start the docker container use the following:

```bash
cd ./docker-image

docker build -t aks-deployment .
```

Once build has finished, you can use the below command to gain CLI access:

```bash
docker run -it aks-deployment:latest /bin/bash
```

Once inside the working directory is:

```bash
cd ~/deployment/aks-deployment-icap
```
### 1.2 Change Icap-infrastructure branch

This step is optional but you can change the branch you wish to deploy with. This can be useful for deploying a branch you've created, that is isolated from Dev and Main.

```bash
cd charts/icap-infrastructure

git checkout <name of branch>
```

Now when you run the deployment it will use the charts from this branch.

### 1.2 Log in to Azure CLI

```bash
az login

az account set --subscription b8177f86-515f-4bff-bd08-1b9535dbc31b
```

### 1.3 Edit terraform.tfvars 

Open ```terraform.tfvars``` and change the suffix to something unique (not exceeding more than 5 chars) and make sure ```enable_argocd_pipeline``` is set to false and ```enable_helm_deployment``` is set to true.

Also if you're deploying a different branch please make sure ```revision``` matches the branch you are deploying.

```bash
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

### 1.4 Change key in backend.tfvars

You will also need to change to the key within the ```backend.tfvars``` as this will store you deployments state. The only part that needs to be unique is everything before ```.terraform.tfstate```

```bash
resource_group_name  = "gw-icap-tfstate"
storage_account_name = "tfstate263"
container_name       = "gw-icap-tfstate"
key                  = "03qauks.terraform.tfstate"
```

### 1.5 Init and Apply

Now you're ready to init and apply 

```bash
terraform init -backend-config="backend.tfvars"
```

```bash
terraform apply -var-file=terraform.tfvars
```

Once terraform has finished the ICAP and File Drop clusters, storage account, key vault and charts would have been deployed. The URLs for the services use the following naming convention:

```bash
icap-$SUFFIX.$REGION.cloudapp.azure.com

management-ui-$SUFFIX.$REGION.cloudapp.azure.com

file-drop-$SUFFIX.$REGION.cloudapp.azure.com
```

### 1.6 Destroying the deployment

In order to destroy the terraform deployment, all you need to do is the following:

```bash
terraform destroy -var-file=terraform.tfvars
```

Let this complete and then the deployment will be destroyed.

## 2. Deployment and Code documentation

## 2.1 Deployment Guide

For a more detailed guide please use the following README's:

[Terraform-Guide - With ArgoCD Pipeline](/documentation/Terraform/terraform-guide-with-argo.md)

[Terraform-Guide - Without ArgoCD Pipeline](/documentation/Terraform/terraform-guide-without-argo.md)


## 2.2 Code Breakdown

The following document covers some of the more custom code used in the deployment, I have not covered all code in this as most of the documentation can be found on the official Hashicorp website. To see the Code Breakdown use the following README:

[Code-Breakdown](/documentation/Terraform/code-breakdown.md)

## 3. ArgoCD

### 3.1 Documentation

For full documentation regarding using, deploying and installing ArgoCD please see the following documents:

[Installation-Guide](/documentation/Argocd/installation-guide.md)

[User Guide](documentation/Argocd/user-guide.md)

[Deployment-Guide](/documentation/Argocd/deployment-guide.md)
