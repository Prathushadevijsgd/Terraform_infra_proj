pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout Terraform code from GitHub
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Prathushadevijsgd/Terraform_infra_proj']])
            }
        }


        stage('Terraform Validate') {
            steps {
                script {
                    echo 'Validating Terraform configuration...'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo 'Running Terraform plan...'
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform Apply?', ok: 'Apply'  // Manual approval
                script {
                    echo 'Applying Terraform plan to provision infrastructure...'
                    // Use withCredentials block to inject AWS credentials securely
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        // AWS credentials are injected into the environment variables automatically
                        sh 'terraform apply tfplan'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                input message: 'Approve Terraform Destroy?', ok: 'Destroy'  // Manual approval
                script {
                    echo 'Destroying infrastructure...'
                    // Use withCredentials block to inject AWS credentials securely
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        // AWS credentials are injected into the environment variables automatically
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace after the job runs
            echo 'Cleaning up workspace...'
            cleanWs()
        }

        success {
            echo 'Terraform infrastructure successfully provisioned or destroyed.'
        }

        failure {
            echo 'There was an error in the Terraform process.'
        }
    }
}
