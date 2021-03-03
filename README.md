# Overview

This Terraform deployment will deploy the following resources:

- Storage Account
- Key vault
- AKS Cluster
- All charts needed for ICAP Services via the Helm Provider
- ArgoCD cluster for managing pipeline


## Table of contents

- [Overview](#overview)
  - [Table of contents](#table-of-contents)
  - [1. Pre-requisites](#1-pre-requisites)
    - [Azure Subscription Pre Requisite](#azure-subscription-pre-requisite)
  - [2. Usage](#2-usage)
    - [2.1 Clone Repo.](#21-clone-repo)
    - [2.2 Firstly make sure you are logged in and using the correct subscription.](#22-firstly-make-sure-you-are-logged-in-and-using-the-correct-subscription)
    - [2.3 Add Terraform Backend Key to Environment](#23-add-terraform-backend-key-to-environment)
    - [2.4 File Modifications](#24-file-modifications)
  - [4. Pre deployment](#4-pre-deployment)
    - [4.1 ICAP Port customization](#41-icap-port-customization)
  - [5. Deployment](#5-deployment)
    - [5.1 Setup and Initialise Terraform](#51-setup-and-initialise-terraform)
  - [6. ArgoCD](#6-argocd)
    - [Documentation](#documentation)

## 1. Pre-requisites
- Terraform
- Kubectl
- Helm
- Openssl
- Azure CLI 
- Bash terminal or terminal able to execute bash scripts
- JSON processor (jq)
- Git
- Microsoft account
- Azure Subscription
  - Owner or Azure account administrator role on the Azure subscription
- Dockerhub account 
- Tarball containing all images for ICAP service

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| kubectl | ~> 1.19 |
| helm | ~> 3.4 |
| az cli | ~> 2.17 |
| jq | ~> 1.6 |
| Openssl | ~> 1.1 |
| git | ~> 2.27.0 |

### Azure Subscription Pre Requisite

- There should be atleast one subscription associated to azure account
- The subscription should have **Contributor** role which allows user to create and manage virtual machines
- A service principle with Contributer rights within the subscription of choice
  - You will need the ```ClientID``` and ```ClientSecret```
- This documentation will provision a managed Azure Kubernetes (AKS) cluster on which to deploy the application. 
- This cluster has configured to auto scaling and  runs on a minimum of 4 nodes and maximum of 100 nodes.
- The specification of the nodes is defined in the `modules/aks01` configuration of this deployment
- The default configuration is to run 4 nodes of which will consume one virtual CPU’s (vCPU) of  type **Standard_DS4_v2** type anf **100 gb** on disk size  -
- The total amount of vCPU available in an Azure region is determined by the subscription itself.
- When deploying, it is essential to ensure that there is enough vCPU available within your subscription to provision the node type and count specified.

## 2. Usage

### 2.1 Clone Repo.

```
git clone https://github.com/k8-proxy/icap-aks-delivery.git
cd icap-aks-delivery
git submodule init
git submodule update

```
   
### 2.2 Firstly make sure you are logged in and using the correct subscription.

```bash

az login
az account list --output table
az account set -s <subscription ID>

# Confirm you are on correct subscription
az account show

```

### 2.3 Add Terraform Backend Key to Environment

- Check if you have access to keyvault using below command where $VAULT_NAME is output value from step 2.4
```
az keyvault secret show --name terraform-backend-key --vault-name $VAULT_NAME --query value -o tsv
```
- Export the environment variable "ARM_ACCESS_KEY" to be able to initialise terraform

```
export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name $VAULT_NAME --query value -o tsv)
```
 
- Check if you can access ARM_ACCESS_KEY as variable
```
echo $ARM_ACCESS_KEY
```
- In case setup healthcheck returns any errors, fix them before proceeding

### 2.4 File Modifications

- backend.tfvars - this will be used as azure backend to store deployment state.

- terraform.tfvars

```
vim terraform.tfvars

# give a valid region name
azure_region="UKWEST"

# give a short suffix, maximum of 3 character.
suffix="stg"

```

## 4. Pre deployment

### 4.1 ICAP Port customization
- By default icap-server will run on port 1344 for SSL and 1345 for TLS
- If you want to customize the above port, please follow below procedure
```
vim terraform.tfvars
```
- Edit variables `icap_port` and `icap_tlsport` according to requirement and Save it.

Note : Please avoide port 80, 443 since this will be used for file-drop UI.

## 5. Deployment
### 5.1 Setup and Initialise Terraform

- Run following:
```
terraform init -backend-config="backend.tfvars" 

```
- Run terraform validate/refresh to check for changes within the state, and also to make sure there aren't any issues.
```
terraform validate

#Output should be: Success! The configuration is valid.
```

- Run
```
terraform plan -var-file=terraform.tfvars
```

- Now you're ready to run apply
``` 
terraform apply -var-file=terraform.tfvars

# You will get below output. Make sure to enter YES when prompt
Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.
Enter a value: 
Enter "yes"
```

## 6. ArgoCD

### Documentation

For full documentation regarding using, deploying and installing ArgoCD please see the following documents:

[Installation-Guide](/documentation/Argocd/installation-guide.md)

[User Guide](documentation/Argocd/user-guide.md)

[Deployment-Guide](/documentation/Argocd/deployment-guide.md)
