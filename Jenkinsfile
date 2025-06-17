pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/KaioAlves07/kablink-docker.git'
        BRANCH_BASE = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "*/${env.BRANCH_BASE}"]],
                    userRemoteConfigs: [[
                        url: "${env.REPO_URL}",
                        credentialsId: 'github-token'
                    ]]
                ])  
            }
        }

        stage('Validação') {
            steps {
                echo 'Simulando testes e validações...'
                sh 'echo "Tudo certo!"'
            }
        }

        stage('Criar nova versão') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {

                        // Obtém a última versão existente do tipo "vX"
                        def output = sh(
                            script: """git ls-remote --heads https://\$GITHUB_TOKEN@github.com/KaioAlves07/kablink-docker.git \
                                | grep 'refs/heads/v' | awk -F'/' '{print \$3}' | sort -V | tail -n1""",
                            returnStdout: true
                        ).trim()

                        def novaVersao = "v1"
                        if (output) {
                            def ultima = output.replace("v", "").toInteger()
                            novaVersao = "v${ultima + 1}"
                        }

                        echo "Nova versão: ${novaVersao}"

                        // Configura Git para push
                        sh "git config user.email 'jenkins@localhost'"
                        sh "git config user.name 'Jenkins'"

                        // Cria a nova branch e faz push
                        sh "git checkout -b ${novaVersao}"
                        sh "git push https://${GITHUB_TOKEN}@github.com/KaioAlves07/kablink-docker.git ${novaVersao}"

                        // Volta para a branch principal com segurança
                        sh "git fetch origin ${env.BRANCH_BASE}"
                        sh "git checkout -B ${env.BRANCH_BASE} origin/${env.BRANCH_BASE}"
                    }
                }
            }
        }
    }
}
