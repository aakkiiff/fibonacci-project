pipeline {
    agent any 
    environment {
        IMAGE_TAG = "$BUILD_NUMBER"
        DOCKERHUB_USERNAME = "aakkiiff"
        GIT_REPO = "https://github.com/aakkiiff/fibonacci-project/" 

        CLIENT_APP_NAME = "fibonacci-client"
        SERVER_APP_NAME = "fibonacci-server"
        WORKER_APP_NAME = "fibonacci-worker"

        CLIENT_APP_IMAGE = "${DOCKERHUB_USERNAME}/${CLIENT_APP_NAME}"
        SERVER_APP_IMAGE = "${DOCKERHUB_USERNAME}/${SERVER_APP_NAME}"
        WORKER_APP_IMAGE = "${DOCKERHUB_USERNAME}/${WORKER_APP_NAME}"
     }

    stages {
        stage('CLEANUP WORKSPACE'){
            steps{
                script{
                    cleanWs()
                }
            }
        }

        stage("CHECKOUT GIT REPO"){
            steps{
                git "${GIT_REPO}"
            }
        }

        stage("BUILD DOCKER IMAGES"){
            steps{
                sh'docker build --no-cache -t ${CLIENT_APP_IMAGE}:${IMAGE_TAG} -t ${CLIENT_APP_IMAGE}:latest -f ./client/Dockerfile ./client'
                sh'docker build --no-cache -t ${SERVER_APP_IMAGE}:${IMAGE_TAG} -t ${SERVER_APP_IMAGE}:latest -f ./server/Dockerfile ./server'
                sh'docker build --no-cache -t ${WORKER_APP_IMAGE}:${IMAGE_TAG} -t ${WORKER_APP_IMAGE}:latest -f ./worker/Dockerfile ./worker'

            }
        }

        stage("PUSH DOCKER IMAGES TO DOCKERHUB"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
                    // sh'docker login -u ${USER_NAME} -p ${PASSWORD}' bad practice,it stores password in an unencrypted file
                    sh'echo ${PASSWORD} | docker login --username ${USER_NAME} --password-stdin'

                    sh'docker push ${CLIENT_APP_IMAGE}:${IMAGE_TAG}'
                    sh'docker push ${CLIENT_APP_IMAGE}:latest'

                    sh'docker push ${SERVER_APP_IMAGE}:${IMAGE_TAG}'
                    sh'docker push ${SERVER_APP_IMAGE}:latest'

                    sh'docker push ${WORKER_APP_IMAGE}:${IMAGE_TAG}'
                    sh'docker push ${WORKER_APP_IMAGE}:latest'

                    sh'docker logout'
                }
            }
        }

        stage('update eks environment') {
             
            steps {
                bat "kubectl get deploy"
                bat "kubectl apply -f ./k8s"
                bat "kubectl set image deployments/server-deployment server=akifboi/jenkins-cicd-server:%bid%"
                bat "kubectl set image deployments/client-deployment client=akifboi/jenkins-cicd-client:%bid%"
                bat "kubectl set image deployments/worker-deployment worker=akifboi/jenkins-cicd-worker:%bid%"

                echo "hopefully everything will work ......see u soon"
            }
        }

        stage("TRIGGERING THE CONFIG PIPELINE"){
            steps{
                build job: 'fibonacci_config', parameters: [string(name: 'IMAGE_TAG', value: env.IMAGE_TAG)]
            }
        }
        
    }

}