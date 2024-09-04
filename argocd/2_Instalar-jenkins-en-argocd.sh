# ERROR si eres root
whoami | grep root && echo "No corras este script con \"sudo\" ni con el usuario root"  && exit 1

# ERROR si no sirve kubectl
kubectl version | grep -q 'Server Version' || { echo "kubectl no está funcionando, mijo!"; exit 1; }

# Crear namespace "jenkins" en el cluster.
# kubectl create ns jenkins

# Crear un Persistent Volume "PV" para Jenkins, de 1GB.
# el archivo está en argocd/jenkins-pv.yaml
mkdir -p ~/kubernetes/jenkins

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
