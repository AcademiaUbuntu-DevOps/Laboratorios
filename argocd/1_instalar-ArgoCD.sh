# Script para instalar ArgoCD

# ALIAS para minikube
# alias k='minikube kubectl --'
# alias kubectl='minikube kubectl --'

# ERROR si eres root
whoami | grep root && echo "No corras este script con \"sudo\" ni con el usuario root"  && exit 1

# ERROR si no sirve kubectl
kubectl version | grep -q 'Server Version' || { echo "kubectl no está funcionando, mijo!"; exit 1; }

# Agregar el repositorio de bitnami a HELM
helm repo add bitnami https://charts.bitnami.com/bitnami

# Actualizar los reporitorios 
helm repo update

# Instalar ArgoCD
helm upgrade \
    --install argocd oci://registry-1.docker.io/bitnamicharts/argo-cd \
    --create-namespace \
    --namespace argocd 
    # --values argocd_values.yaml 

# copiar argocd_password de ArgoCD y respaldarla
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.argocd_password}" | base64 -d # > argocd_argocd_password.txt

# Instalar "argocd-cli"
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Mostrar credenciales
# echo "Username: \"admin\""
echo "con minikube tal vez tengas que agregar \"--\" "
echo "kubectl -- -n argocd get secret argocd-secret -o jsonpath="{.data.clearPassword}" | base64 -d"


echo "Loguearse en ArgoCD cli"
echo "argocd login 127.0.0.1:8080 --username admin --password XXXXXX --insecure"