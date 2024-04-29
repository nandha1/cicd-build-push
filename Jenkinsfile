pipeline{

    agent any
    tools{
        maven "maven"
    }

    environment{
           APP_NAME = "spring-docker-cicd"
           RELEASE_NO= "1.0.0"
           DOCKER_USER= "nandha572"
           IMAGE_NAME= "%DOCKER_USER%"+"/"+"%APP_NAME%"
           IMAGE_TAG= "%RELEASE_NO%-%BUILD_NUMBER%"
    }

    stages{

        stage('SCM checkout'){
            steps{
            
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nandha1/cicd-build-push.git']])
            }
        }

        stage('Build Process'){
            steps{
                script{
                    bat 'mvn clean install'
                }
            }
        }

      stage('Build Image'){
            steps{
                script{
                    bat 'docker build -t nandha572/%IMAGE_NAME%:%IMAGE_TAG% .'

                }
            }
        }

    stage('deploy Image o hub'){
            steps{
                script{
                  withCredentials([string(credentialsId: 'dp', variable: 'dp')]) {
                        bat 'docker login -u nandha572 -p %dp%'
                        bat 'docker push %IMAGE_NAME%:%IMAGE_TAG%'
                   }
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
</html>''', mimeType: 'text/html', replyTo: 'nandha572@gmail.com', subject: 'Pipeline Status : ${BUILD_NUMBER}', to: 'nandha572@gmail.com'

        }
    }
}