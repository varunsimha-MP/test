variable "cidr_block" {
  type = string
}

variable "vpc" {
  type = map(string)
}

variable "main_ig" {
    type = map(string)
}

variable "route_table" {
    type = map(string)
}

variable "sub_count" {
    type = number
}

variable "pub_subnet_name" {
    type = string
}

variable "pub_sub_cidr_block" {
    type = list(string)
}

variable "pri_sub_cidr_block" {
    type = list(string)
  
}

variable "pri_subnet_name" {
    type = string
}