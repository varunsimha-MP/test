#Networking Moduel

variable "vpc" {
  type = map(string)
}

variable "cidr_block" {
  type = string
}

variable "main_ig" {
  type = map(string)
}

variable "sub_count" {
  type = number
}

variable "route_table" {
  type = map(string)
}

variable "pub_subnet_name" {
  type = string
}

variable "pri_subnet_name" {
  type = string
}

variable "pub_sub_cidr_block" {
  type = list(string)
}

variable "pri_sub_cidr_block" {
  type = list(string)
}
#Instacne module

variable "instance_ingress" {
    type = map(object({
      port = number
      description = string
      protocol = string
      cidr_block = list(string)
    }))
    description = "Applying ingress rule dynamically"
  
}

variable "instance_egress" {
  type = map(object({
    description = string
    port = number
    cidr_block = list(string)
    protocol = string
  }))
  description = "Applying egress rule dynamically"
  
}

variable "ami" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "sg_description" {
  type = string
}

variable "sg_tag_name" {
  type = map(string)
}

#DNS module
variable "domain_name" {
    type = string 
    description = "Root Domain value"
}

variable "subdomain_name" {
    type = string
    description = "Subdomain value"
}

variable "acm_name" {
    type = map(string)
    description = "Certificate Name"
}