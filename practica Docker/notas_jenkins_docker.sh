docker run -d --name jenkins-prueba --network=host -p 8082:8080 -p 50002:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:alpine-jdk21

docker volume inspect jenkins_home

sudo ls /var/snap/docker/common/var-lib-docker/volumes/jenkins_home/_data

