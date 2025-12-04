variable "ami" {
  default = "ami-00bb6a80f01f03502"
}

variable "public_subnet" {
  default = true
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key" {
}

variable "ec2" {
  default = {
    Name = "Test-Terraform"
  }
}

variable "subnet_id" {
  
}

variable "vpc_id" {
  
}

variable "web_ingress_rule" {
  
}

variable "sg" {
  default = {
    Name = "Ec2 SG"
  }
  
}