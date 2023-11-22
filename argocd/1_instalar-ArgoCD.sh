# Script para instalar ArgoCD

# Da un error si no eres root
whoami | grep root || echo "No eres digno, te faltó el \"sudo\""

# Agregar el repositorio de bitnami a HELM
helm repo add bitnami https://github.com/bitnami/charts.git

# Actualizar los reporitorios 
helm repo update

# Instalar ArgoCD
helm install my-release oci://registry-1.docker.io/bitnamicharts/argo-cd

# copiar password de ArgoCD y respaldarla
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd_password.txt

# Hacer port-forward para poder tener acceso a ArgoCD desde Localhost
kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443 &

# Instalar "arcocd cli"
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Guardar la contraseña de ArgoCD
export password=$(cat argocd_password.txt)

# Loguearse en ArgoCD
argocd login 127.0.0.1:8080 --username admin --password $password