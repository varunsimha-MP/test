variable "cidr_block" {
    default = "11.0.0.0/16"
}

variable "vpc" {
  default = {
    Name = "test_vpc"
  }
}

variable "subnet_count" {
    default = "2"
}

variable "pub_subnet" {
    default = {
        Name = "Public Subnet" 
    }
}

variable "pub_cidr" {
  default = ["11.0.0.0/19","11.00.32.0/19"]
}


variable "pri_cidr" {
  default = ["11.0.64.0/19","11.0.96.0/19"]
}

variable "pri_subnet" {
    default = {
      Name = "Private_Subnet" 
    }
}

variable "main_ig" {
  default = {
    Name = "internet_gateway"
  } 
}

variable "main_route" {
  default = {
    Name = "route_table"
  }
}