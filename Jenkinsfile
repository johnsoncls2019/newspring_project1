node {
stage ('SCM Checkout' ) {
git credentialsId: 'git-creds', url: 'https://github.com/johnsoncls2019/spring_project.git'
}
stage ('Mvn package') {
def mvnHome = tool name: 'LocalMaven 3.8', type: 'maven'
def mvnCMD = "${mvnHome}/usr/bin/mvn"
sh " mvn clean package"
}
stage ('Build Docker image') {
sh "docker build -t johnsoncls2019/demo2.0.0 ."
}
stage ('Push docker image') {
withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
sh "docker login -u johnsoncls2019 -p ${dockerHubPwd}"
}
sh 'docker push johnsoncls2019/demo2.0.0'
}
stage ('Run container on Dev server') {
def dockerRun = 'docker run -p 5000:5000 -d  -t --name AchiStarTechnologies johnsoncls2019/demo2.0.0'
def DockerRemove = 'docker rm --force AchiStarTechnologies'
sshagent(['dev-server']) {
sh "ssh -o StrictHostKeyChecking=no root@192.168.44.169 ${DockerRemove}"
sh "ssh -o StrictHostKeyChecking=no root@192.168.44.169 ${dockerRun}"
}
}
}

