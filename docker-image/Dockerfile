FROM centos
RUN yum update -y && \
# Install Pre-Reqs
yum install -y yum-utils && \
yum install -y openssl && \
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
yum -y install terraform && \
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
./get_helm.sh && \
yum install jq -y && \
rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
echo -e $'[azure-cli] \n\
name=Azure CLI \n\
baseurl=https://packages.microsoft.com/yumrepos/azure-cli \n\
enabled=1 \n\
gpgcheck=1 \n\
gpgkey=https://packages.microsoft.com/keys/microsoft.asc' > /etc/yum.repos.d/azure-cli.repo && \
dnf install -y azure-cli && \
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# Install ArgoCD
RUN VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/') && \
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64 && \
chmod +x /usr/local/bin/argocd
# Install Git & Clone Repo
RUN mkdir ~/deployment && \
cd ~/deployment && \
yum install -y git && \
git clone https://github.com/filetrust/aks-deployment-icap.git