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

                        // Obtém a última versão do tipo "vX"
                        def ultimaVersao = sh(
                            script: '''
                                git ls-remote --heads https://$GITHUB_TOKEN@github.com/KaioAlves07/kablink-docker.git |
                                grep 'refs/heads/v' | awk -F'/' '{print $3}' | sort -V | tail -n1
                            ''',
                            returnStdout: true
                        ).trim()

                        def novaVersao = 'v1'
                        if (ultimaVersao) {
                            def numero = ultimaVersao.replace('v', '').toInteger()
                            novaVersao = "v${numero + 1}"
                        }

                        echo "Nova versão: ${novaVersao}"

                        // Configura Git localmente
                        sh 'git config user.email "jenkins@localhost"'
                        sh 'git config user.name "Jenkins"'

                        // Cria nova branch e faz push de forma segura
                        sh "git checkout -b ${novaVersao}"
                        sh '''
                            git push https://$GITHUB_TOKEN@github.com/KaioAlves07/kablink-docker.git $GIT_BRANCH
                        '''.replace('$GIT_BRANCH', novaVersao)

                        // Garante que a branch base existe localmente
                        sh '''
                            git fetch origin $BRANCH_BASE:$BRANCH_BASE
                            git checkout $BRANCH_BASE
                        '''
                    }
                }
            }
        }
    }
}
