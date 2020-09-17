node {
   stage('Preparation') { 
          git 'https://gitlab.com/Jai-k7/javaproject.git'
   }
   stage('init') {
    sh '''
cd terraform/infra; terraform init 
'''
   }
   stage('plan') {
    sh '''cd terraform/infra; terraform plan '''
   }
   stage("Terraform apply"){
        script {
            // Define Variable
             def USER_INPUT = input(
                    message: 'User input required - Some Yes or No question?',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                             choices: ['no','yes'].join('\n'),
                             name: 'input',
                             description: 'Menu - select box option']
                    ])
            echo "The answer is: ${USER_INPUT}"
            if( "${USER_INPUT}" == "yes"){
             sh 'cd terraform/infra; terraform apply --auto-approve'
            } else {
                sh 'echo "terraform apply cancelled"'
            }
        }}
}