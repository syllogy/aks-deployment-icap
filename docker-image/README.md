# Docker Image for Deployment

This image has been created so we can isolate deployments and stop edge case issues between each users system.

You can pull the image from our private Dockerhub or build the image with the Dockerfile.

## Building and using the image

To build the image run the command below:+

```bash
docker run -it aks-deployment:latest /bin/bash
```

After it has finished building, you can then use the below command to get exec access and then start using the container:

```bash
docker run -it aks-deployment:latest /bin/bash
```

***Please Ignore below:***

Dockerfile - pre-reqs

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