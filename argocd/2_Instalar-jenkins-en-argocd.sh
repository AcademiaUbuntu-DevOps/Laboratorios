# Da un error si no eres root
whoami | grep root || echo "¡¡TU NO TIENES PODER AQUI!!, te faltó el \"sudo\""
 
# Crear namespace "jenkins" en el cluster local de microk8s.
kubectl create ns jenkins

# Crear un Persistent Volume "PV" para Jenkins, de 1GB.
# el archivo está en argocd/jenkins-pv.yaml
mkdir -p /var/lib/microk8s-pv/jenkins

#parmisos totales al PATH jenkins, (sólo por tratarse de un laboratorio)
chmod 777 /var/lib/microk8s-pv/jenkins

# Crear el volumen persistente
kubectl apply -f jenkins-pv.yaml # no ncesita namespace

# Crear un Persistent Volume Claim "PVC" para Jenkins, de 1GB.
# el archivo está en argocd/jenkins-pvc.yaml
kubectl apply -f jenkins-pvc.yaml # el namespace está definido dentro del archivo

# Instalar JENKINS en ArgoCD
argocd app create jenkins \
   --repo https://charts.bitnami.com/bitnami \
   --helm-chart jenkins \
   --dest-server https://kubernetes.default.svc \
   --dest-namespace jenkins \
   --values-literal-file jenkins_values.yaml \
   --upsert --revision 12.2.3

# La contraseña de jenkins está en el secret, que se puede revelar en LENS, o en el mismo ArgoCD.

# copiar password de JENKINS y respaldarla
kubectl -n jenkins get secret jenkins -o jsonpath="{.data.jenkins-password}" | base64 -d > jenkins_password.txt

echo "Usuario: user"
cat jenkins_password.txt
