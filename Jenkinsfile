pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building project..."
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                echo "Deploying project..."
                mkdir -p /var/www/html
                cp -r * /var/www/html/
                '''
            }
        }
    }
}
