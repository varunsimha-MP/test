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
variable "acm_name" {
    type = map(string)
    description = "Certificate Name"
}

variable "domain_name" {
    type = string 
    description = "Root Domain value"
}

variable "subdomain_name" {
    type = string
    description = "Subdomain value"
}
