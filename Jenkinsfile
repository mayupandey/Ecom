pipeline{
    agent any
    environment{
        FLUTTER_HOME= "C:\\Users\\Microsoft.000\\Desktop\\flutter\\bin"
        ANDROID_HOME="C:\\Users\\Microsoft.000\\Local\\Android\\Sdk"
        JAVA_HOME="C:\\ProgramFiles\\Java\\jdk-11\\"
    }
    stages{
        stage('Clone Repo'){
            steps{
                git branch:'main', url: 'https://github.com/mayupandey/Ecom'
            }
        }

        stage('Flutter Build App Bundle'){
            steps{
                bat "${FLUTTER_HOME}flutter build appbundle"
            }
        }
    }
}