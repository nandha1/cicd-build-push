pipeline{

    agent any
    tools{
        maven "maven"
    }

    environment{
           APP_NAME = "spring-docker-cicd"
           RELEASE_NO= "1.0.0"
           DOCKER_USER= "javatechie4u"
           IMAGE_NAME= "${DOCKER_USER}"+"/"+"${APP_NAME}"
           IMAGE_TAG= "${RELEASE_NO}-${BUILD_NUMBER}"
    }

    stages{

        stage("SCM checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/javatechie-devops/jenkins-ci-cd.git']])
            }
        }

        stage("Build Process"){
            steps{
                script{
                    sh 'mvn clean install'
                }
            }
        }

        stage("Build Image"){
            steps{
                script{
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage("Deploy Image to Hub"){
            steps{
                withCredentials([string(credentialsId: 'dp', variable: 'dp')]) {
                 sh 'docker login -u javatechie4u -p ${dp}'
                 sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }


    }

    post{
        always{
            emailext attachLog: true,
            body: ''' <html>
    <body>
        <p>Build Status: ${BUILD_STATUS}</p>
        <p>Build Number: ${BUILD_NUMBER}</p>
        <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
    </body>
</html>''', mimeType: 'text/html', replyTo: 'javatechie.learning@gmail.com', subject: 'Pipeline Status : ${BUILD_NUMBER}', to: 'javatechie.learning@gmail.com'

        }
    }
}
