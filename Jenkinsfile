pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }   
        }

        stage('Validação') {
            steps {
                echo 'Executando testes/validações...'
                sh 'echo "Tudo certo!"'
            }
        }

        stage('Deploy (main only)') {
            when {
                branch 'main'
            }
            steps {
                echo 'Executando deploy em produção...'
                // Seu script de deploy aqui
            }
        }
    }

    post {
        success {
            githubNotify context: 'ci/jenkins', status: 'SUCCESS', description: 'Build passou com sucesso', targetUrl: "${env.BUILD_URL}"
        }
        failure {
            githubNotify context: 'ci/jenkins', status: 'FAILURE', description: 'Build falhou', targetUrl: "${env.BUILD_URL}"
        }
    }
}