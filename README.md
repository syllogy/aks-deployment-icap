# aks-deployment-icap

Deployment for I-CAP Azure resources and AKS Deployment using Terraform

### Attaching ACRs to cluster

The blow command can be run multiple times to attach ACRs to the working cluster. This is mainly for development purposes as there are various pipelines setup with images being sent to multiple different clusters. In theory as the final product/project is nearing the end we should have a single source of truth for all images.

```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr1
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr2
```
