node {
    // Checkout stage
    stage('Git Checkout') {
        checkout scm  // Assuming the SCM definition is configured in Jenkins
    }

    // Build and Test Code stage
    stage('Build and Test Code') {
        def mvnHome = tool 'Maven' // Retrieves the Maven installation configured in Jenkins
        sh "${mvnHome}/bin/mvn clean package"
    }

    // Uncommented for demonstration purposes
    // stage('SonarQube Analysis') {
    //     withSonarQubeEnv('SonarQube-1') {
    //         def mvnHome = tool 'Maven'
    //         sh """
    //             ${mvnHome}/bin/mvn sonar:sonar \
    //             -Dsonar.host.url=http://sonarqube-17636:9000 \
    //             -Dsonar.login=
    //         """
    //     }
    // }

    // Deploy stage
    stage('Deploy') {
        docker.image('docker:19.03.12').inside('-v /var/run/docker.sock:/var/run/docker.sock') {
            sh '''
            export DOCKER_HOST=unix:///var/run/docker.sock
            docker tag petclinic-app:${env.BUILD_ID} petclinic-app:latest
            docker push petclinic-app:latest
            '''
        }
        // Running Ansible playbook
        ansiblePlaybook(
            playbook: 'deploy-petclinic.yml',
            inventory: 'localhost,',
            extras: "-e build_id=${env.BUILD_ID}"
        )
    }

    // Post actions
    post {
        always {
            echo "Things mostly went on well"
        }
        success {
            echo "Build completed successfully"
        }
        failure {
            echo "Build failed check logs for errors"
        }
    }
}
