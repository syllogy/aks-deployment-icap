# Terraform Guide

## Table of Contents

- [Terraform Guide](#terraform-guide)
  - [Table of Contents](#table-of-contents)
  - [1. Pre-requisites](#1-pre-requisites)
    - [1.1 Azure Subscription Pre Requisite](#11-azure-subscription-pre-requisite)
  - [2. Usage](#2-usage)
    - [Clone the repo](#clone-the-repo)
    - [2.1 Build and Start Docker Container](#21-build-and-start-docker-container)
    - [2.2 Log in to Azure CLI](#22-log-in-to-azure-cli)
    - [2.3 Login to ArgoCD](#23-login-to-argocd)
    - [2.4 File Modifications](#24-file-modifications)
  - [4. Pre deployment](#4-pre-deployment)
    - [4.1 ICAP Port customization](#41-icap-port-customization)
  - [5. Deployment](#5-deployment)
    - [5.1 Setup and Initialise Terraform](#51-setup-and-initialise-terraform)
    - [Accessing Endpoints](#accessing-endpoints)
    - [Destruction](#destruction)

## 1. Pre-requisites

- Docker
- Microsoft account
- Azure Subscription
- Owner or Azure account administrator role on the Azure subscription
- Dockerhub account

| Name | Version |
|------|---------|
| docker | >= 20.10.2 |

***Please note this version was on MacOS and could differ to the latest version on Windows and Linux. Just mke sure you're running the latest version.***

### 1.1 Azure Subscription Pre Requisite

- There should be atleast one subscription associated to azure account
- The subscription should have **Contributor** role which allows user to create and manage virtual machines
- A service principle with Contributer rights within the subscription of choice
- This documentation will provision a managed Azure Kubernetes (AKS) cluster on which to deploy the application. 
- This cluster has configured to auto scaling and  runs on a minimum of 4 nodes and maximum of 100 nodes.
- The specification of the nodes is defined in the `modules` within each deployment
- The default configuration is to run 4 nodes of which will consume one virtual CPU’s (vCPU) of  type **Standard_DS4_v2** type anf **100 gb** on disk size  -
- The total amount of vCPU available in an Azure region is determined by the subscription itself.
- When deploying, it is essential to ensure that there is enough vCPU available within your subscription to provision the node type and count specified.

## 2. Usage

### Clone the repo

For now this step is here so you can access the Dockerfile. Once the container is in our Dockerhub account it will be removed.

```bash
git clone https://github.com/filetrust/aks-deployment-icap.git
```

### 2.1 Build and Start Docker Container

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

***Next step is optional - the default branch is main***

This step you can also change the branch of the the Icap-Infrastructure submodule as well. This can enable you to use either the Develop or Main branch or a branch that you've created to do testing.

```bash
cd charts/icap-infrastructure

git checkout <name of branch>
```

Now when you run the deployment it will use the charts from this branch.
   
### 2.2 Log in to Azure CLI

```bash
az login

az account set --subscription b8177f86-515f-4bff-bd08-1b9535dbc31b
```

### 2.3 Login to ArgoCD

Firstly you will need to get the context for the ArgoCD cluster, this can be found on Azure or use the command below:

```bash
az aks get-credentials --resource-group icap-aks-rg-argo --name icap-aks-clu-argo-uksouth
```

Next you'll need to add the Argo password and IP to env variables

```bash
ARGOPASS=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name -n argocd | cut -d'/' -f 2)
```

```bash
ARGOIP=$(kubectl get svc -n argocd argocd-server -n argocd -o jsonpath="{.status.loadBalancer.ingress[*].ip}")
```

Using the username "admin" and the password above, login using the public IP of ArgoCD

```bash
argocd login $ARGOIP --name argocd-aks-deploy --username admin --password $ARGOPASS --insecure
```

### 2.4 File Modifications

```
cd ./deployments/04-template
```

- backend.tfvars - this will be used as azure backend to store deployment state.
The only part of the ```backend.tfvars``` you will need to change is the first part of the key. See example below:

```bash
key                  = "<must be unique>.terraform.tfstate"
```

- terraform.tfvars

***Please note that ```enable_argocd_pipeline``` must be set to ```true``` - you will also need to make sure ```enable_helm_deployment``` is set to ```false```

```bash
vim terraform.tfvars

# give a valid region name
azure_region="UKWEST"

# give a short suffix, maximum of 3 character.
suffix="stg"

# Should be left as default
domain                 = "cloudapp.azure.com"

# Should be left as default
icap_port              = 1344
icap_tlsport           = 1345

# This is the name of the ArgoCD server - should be left as default
argocd_cluster_context = "argocd-aks-deploy"

# Boolean to enable or disable the ArgoCD Pipeline
enable_argocd_pipeline = true

# Boolean to deploy using Helm
enable_helm_deployment = false

# The branch you wish to use with the ArgoCD Pipeline (must be a valid created branch, this will not create a branch for you)
revision               = "main"
```

## 4. Pre deployment

### 4.1 ICAP Port customization

***This step can be ignored if you do not plan changing the ICAP Ports***

- By default icap-server will run on port 1344 for SSL and 1345 for TLS
- If you want to customize the above port, please follow below procedure
```bash
vim terraform.tfvars
```
- Edit variables `icap_port` and `icap_tlsport` according to requirement and Save it.

Note : Please avoid port 80, 443 since this will be used for file-drop UI.

## 5. Deployment
### 5.1 Setup and Initialise Terraform

- Run following:
```bash
terraform init -backend-config="backend.tfvars"
```
- Run terraform validate/refresh to check for changes within the state, and also to make sure there aren't any issues.

```bash
terraform validate

# Output should be: Success! The configuration is valid.
```

- Now you're ready to run apply
```bash
terraform apply -var-file=terraform.tfvars

# You will get below output. Make sure to enter YES when prompt
Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.
Enter a value: 
Enter "yes"
```

### Accessing Endpoints

The endpoints for all the deployments follow the below format

```bash
icap-$SUFFIX.$REGION.$DOMAIN

management-ui-$SUFFIX.$REGION.$DOMAIN

file-drop-$SUFFIX.$REGION.$DOMAIN
```

so you can access them by checking ```terrraform.tfvars``` and checking what the above variables were set to.

You should also have the kube contexts within the docker container to check the clusters directly. 

If you want to access them outside of the docker container, then you will need to get the credentials for the cluster from the Azure Portal.

### Destruction

In order to destroy the terraform deployment, all you need to do is the following:

```bash
terraform destroy -var-file=terraform.tfvars
```

Let this complete and then the deployment will be destroyed.