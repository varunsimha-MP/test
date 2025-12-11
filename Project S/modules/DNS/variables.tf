variable "domain_name" {
    type = string
}

variable "subdomain_name" {
    type = string
}

variable "public_ip" {
    type = string   
  
}

variable "acm_name" {
    type = map(string)
}