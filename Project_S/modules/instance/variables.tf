variable "ami" {
    type = string
}

variable "instance_type" {
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

variable "subnet_id" {
    type = map(string)
  
}

variable "sg_tag_name" {
    type = map(string)
  
}
variable "sg_name" {
    type = string
}

variable "main_vpc" {
  type = string
}

variable "sg_description" {
    type = string
}

variable "instance_ingress" {
    type = map(object({
        description = string
        port = number
        cidr_block = list(string)
        protocol = string
    })) 
}

variable "instance_egress" {
    type = map(object({
      description = string
      port = number
      cidr_block = list(string)
      protocol = string
    }))
  
}
