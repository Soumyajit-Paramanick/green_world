pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/Soumyajit-Paramanick/green_world'
            }
        }

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
