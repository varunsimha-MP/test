terraform {
  backend "s3" {
    bucket = "terraform-devops-backend-file"
    key = "terraform.tfstate"
    encrypt = true
    region = "ap-southeast-1"
    use_lockfile = true    
  }
}