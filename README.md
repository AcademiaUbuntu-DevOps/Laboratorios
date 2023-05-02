# Laboratorio de la Clase 1
## Introdución a Microservicios


#### Instalar las siguientes aplicaciones en tu Sistema Operativo, nótese algunos como WSL no son necesario si ya usas Linux:
- [Visual Studio Code](https://code.visualstudio.com/Download)
- [GitHub Desktop](https://desktop.github.com/)
- [WSL: Windows Subsystem for Linux](https://learn.microsoft.com/es-es/windows/wsl/install)
- [Actualizar a WSL2](https://learn.microsoft.com/es-es/windows/wsl/install#upgrade-version-from-wsl-1-to-wsl-2)
- [Ubuntu en Windows](https://apps.microsoft.com/store/detail/ubuntu-22042-lts/9PN20MSR04DW)
- [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701)


#### Dentro de Windows Subsystem for Linux (WSL2) debes instalar las siguientes aplicaciónes:
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
```sh
# Ejecutaren WSL2:
docker run hello-world
```
- [microk8s](https://microk8s.io/docs/getting-started) 
- [kubectl](https://microk8s.io/docs/getting-started)
- [HELM](https://helm.sh/docs/intro/install/#from-apt-debianubuntu)
- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [pip3](https://pip.pypa.io/en/stable/installation/#ensurepip)
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

##### Es recomendable revisar la página oficial de cada software para saber qué se está instalando y qué problema resuelve cada app.

### Abrir una cuenta en
- [DockerHub](https://hub.docker.com/)
- [GitHub](https://github.com)
- [GitLab](https://gitlab.com/users/sign_up)
- [Azure DevOps](https://azure.microsoft.com/en-us/products/devops/)
- [Amazon Web Services - AWS](https://aws.amazon.com/es/?nc1=h_ls)
- [Microsoft Azure](https://portal.azure.com/#home)

### Seguir nuestro repositorio en GitHub
https://github.com/AcademiaUbuntu-DevOps 

### Practcar comandos básicos de Linux
```sh
man
cd
cd..
ls
ll
touch miarchivo.txt
echo "hola Linux" > miarchivo.txt
cat miarchivo.txt
cp miarchivo.txt rm COPIAmiarchivo.txt
mv miarchivo.txt nuevoNombre.txt
rm nuevoNombre.txt
clear
history
cat 
vim # se sale con "ESC" :wq
top
apt update  #  Revisar si hay actualizaciones disponibles
apt upgrade  # Actualizar el sistema operativo 
apt install apache2   -y     # Instalamos el servidor HTTP
exit # salir del terminal 
```

#### Enviarnos la versión de cada software recien instalado en WSL2 a ubuntu.coachesconsultores@gmail.com 
```sh
docker --version
microk8s --version 
etc...
```

> La palabra Ubuntu viene a significar algo así como 
> "soy porque tú eres. Eres porque somos"


https://www.linkedin.com/company/ubuntuacademia

https://www.instagram.com/ubuntu.consultores/ 



