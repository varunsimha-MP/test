#Network
variable "main_vpc" {
    type = map(string)
}

variable "main_ig" {
    type = map(string)
}

variable "cidr_block" {
    type = string
}

variable "public_route_table" {   
    type = map(string)
}

variable "private_route_table" {
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

variable "pri_subnet_count" {
    type = number
}

variable "pub_subnet_count" {
    type = number
}

variable "eip" {
    type = map(string)
}

variable "nat" {
    type = map(string)
}

variable "s3_endpoint" {
    type = map(string)
}

variable "secret_endpoint" {
    type = map(string)
}

variable "api_endpoint" {
    type = map(string)
}

variable "security_groups" {
  description = "Map of security groups with dynamic rules"
  type = map(object({
    description = string

    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string))
      sg_refs     = optional(list(string))
    }))

    egress = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string))
      sg_refs     = optional(list(string))
    })))
  }))
}