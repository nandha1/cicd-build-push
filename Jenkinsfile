pipeline{

    agent any
    tools{
        maven "maven"
    }

    environment{
           app_name = "spring-docker-cicd"
           release_no= "1.0.0"
           docker_user= "nandha572"
           image_name= "%docker_user%"+"/"+"%app_name%"
           image_tag= "%release_no%-%BUILD_NUMBER%"
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
                    bat 'docker build -t nandha572/spring-cicd:2.0 .'

                }
            }
        }

    stage('deploy Image o hub'){
            steps{
                script{
                  withCredentials([string(credentialsId: 'dp', variable: 'dp')]) {
                        bat 'docker login -u nandha572 -p %dp%'
                        bat 'docker push %image_name%:%image_tag%'
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