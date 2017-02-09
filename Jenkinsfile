node('linuxee-docker') {
    
   def containerName="linuxee-docker-android"
   def imageName="jenkins-android-docker-slave"
   def image
   def options="--restart=always --name $containerName -v /var/run/docker.sock:/var/run/docker.sock"
   def key=""
   def url=""
   def tunnel=""
   def args="-headless -tunnel $tunnel -url $url $key $containerName"
   
   stage('Stop and remove container') {
    sh "docker stop $containerName || echo $containerName is not running"
   }
   
   stage('Remove container') {
    sh "docker rm $containerName || echo $containerName has been already removed"
   }
   
   stage('Build image') {
     image = docker.build("$imageName")
   }
   
   stage('Run container') {
    image.run("$options","$args")
   }
}