repositoryUrl = "https://github.com/dimpledalby07/testing-express-api.git"
branch = "master"
pipeline {
  agent any
  stages {
    
    stage ('Checkout') {
        steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: "${repositoryUrl}"]]])
            sh ''' ls -al '''
        }
    }
    stage ('Build') {
        steps {
            sh '''npm install --save express
            npm install --save express
            npm install --save-dev supertest tape
            npm install --save-dev tap-spec'''
        }
         
    }
    stage ('Test') {
        steps {
            sh '''npm test'''
        }
         
    }
    stage ('Package Build') {
        steps {
            sh ''' zip -r -D express-api.zip * -x "./terraform/*" "./scripts/*" .gitignore'''
        }
    }
    stage ('Deploy app') {
        steps {
            sh '''cd terraform
                  /usr/local/bin/terraform init
                  /usr/local/bin/terraform plan
                  /usr/local/bin/terraform apply -auto-approve'''
        }
    }
  }
}
