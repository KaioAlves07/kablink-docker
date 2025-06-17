pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/KaioAlves07/kablink-docker.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Simulando build do sistema'
                sh 'echo "Executando build..."'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Simulando deploy (copiar arquivos .jsp no Tomcat)'
                sh 'echo "Deploy no container kablink..."'
            }
        }
    }
}
