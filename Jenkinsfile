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
}