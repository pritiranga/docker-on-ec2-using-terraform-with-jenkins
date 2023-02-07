pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	environment {
		AWS_key = credentials("AWS")
	}

	stages{
		stage("Check Terraform Version"){
			steps{
				sh 'terraform --version'
			}
		}

		stage("Terraform init"){
			steps{
				sh 'terraform init'
			}
		}

		stage("Terraform Plan"){
			steps{
				sh 'terraform plan'
			}
		}

		stage('Terraform apply'){
			steps{
				sh 'terraform apply --auto-approve'
			}
		}

	} //stages closing
} //pipeline closing