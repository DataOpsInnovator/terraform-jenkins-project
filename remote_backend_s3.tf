/*terraform {
  backend "s3" {
    bucket = "dev-proj-1-jenkins-remote-state-bucket-123456"
    key    = "devops-project-1/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}*/


terraform {
  backend "s3" {
    bucket = "dev-proj-1-jenkins-remote-state-bucket-123" 
    key    = "devops-project-1/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}

