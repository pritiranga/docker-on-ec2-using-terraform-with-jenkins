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

		stage("Terraform plan"){
			steps{
				sh 'terraform plan'
                sh 'terraform untaint aws_security_group.sg'
                sh 'terraform untaint aws_instance.ec2'
			}
		}

		stage('Terraform apply'){
			steps{
				sh 'terraform apply --auto-approve'
			}
		}

	} //stages closing
} //pipeline closing