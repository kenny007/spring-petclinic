pipeline {
    agent any
    stages {
        stage('Git Checkout ') {
            steps {
                git(url: 'https://github.com/kenny007/spring-petclinic.git', branch: 'petty')
            }

        }

        stage ('Build Code') {
            steps {
                script {
                    def mvnHome = tool 'Maven' // 'Maven' is the name given to the Maven installation in Global Tool Configuration
                    sh "${mvnHome}/bin/mvn clean package"
                }

            }
        }

        stage ('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube-1') { // 'SonarQube' is the name given to the SonarQube server in Jenkins configuration
                    script {
                        def mvnHome = tool 'Maven'
                        sh "${mvnHome}/bin/mvn sonar:sonar"
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Installation ran but not sure if things succeeded!"
        }
        success {
            echo "This wiwll only run if setup was completely done"
        }
        failure {
            echo "Build failed check logs for errors"
        }
    }

}