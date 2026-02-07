variable "region" { 
default = "us-east-1" 
} 
variable "vpc_cidr" { 
default = "10.0.0.0/16" 
} 
variable "public_subnet_cidrs" { 
type    
= list(string) 
default = ["10.0.1.0/24", "10.0.2.0/24"] 
} 
variable "ami_id" { 
default = "" 
} 
variable "instance_type" { 
default = "t3.micro" 
} 
variable "key_name" { 
description = "Existing EC2 Key Pair Name" 
type    
    = string 
} 
variable "desired_capacity" { default = 2 } 
variable "min_size" { default = 1 } 
variable "max_size" { default = 3 } 
