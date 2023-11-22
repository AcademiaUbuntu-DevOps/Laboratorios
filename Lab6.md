# Laboratorio de la Clase 6
## CI/CD Pipelines

### TAREA / ENTREGABLE

1) Instalar Jenkins en ArgoCD con estos pasos

```sh
# Iniciar Microk8s
microk8s start

# Habilitar el Addon de ArgoCD en microk8s
microk8s enable argocd

# copiar password de ArgoCD y respaldarla
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Hacer port-forward para poder tener acceso a ArgoCD desde Localhost
kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443

# Instalar "arcocd cli"
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Loguearse en ArgoCD
argocd login 127.0.0.1:8080
# admin # password
 
# Crear namespace "jenkins" en el cluster local de microk8s.
kubectl create ns jenkins

# Agregar el repositori de bitnami a HELM
helm repo add bitnami https://github.com/bitnami/charts.git

# Actualizar los reporitorios de HELM 
helm repo update

# Crear un Persistent Volume "PV" para Jenkins, de 1GB.
# el archivo está en argocd/jenkins-pv.yaml
mkdir -p /var/lib/microk8s-pv/jenkins
cd /var/lib/microk8s-pv/
chmod 777 jenkins
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
Usiario: user

# copiar password de JENKINS y respaldarla
kubectl -n jenkins get secret jenkins -o jsonpath="{.data.jenkins-password}" | base64 -d

# si no funciona, daerror al instalar porque no encuentra el repositorio, es posible que tengas que reiniciar el clúster de microk8s
microk8s stop
microk8s start

```

  Abrir la siguiente URL en tu explorador
  127.0.0.1:8080 

  y loguarse en ArgoCD


Revisar los siguientes proyectos
- https://www.jenkins.io/
- https://github.com/jenkins-x/jx
- https://argo-cd.readthedocs.io/en/stable/ 


> La palabra Ubuntu viene a significar algo así como 
> "Soy porque tú eres, eres porque somos"


[LinkedIn](https://www.linkedin.com/company/ubuntuacademia)

[Instagram](https://www.instagram.com/ubuntu.consultores/) 
