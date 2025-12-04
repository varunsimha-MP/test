provider "aws" {
    region = "ap-southeast-1"
    assume_role {
      role_arn = ""
      session_name = "terraform"
    }
}