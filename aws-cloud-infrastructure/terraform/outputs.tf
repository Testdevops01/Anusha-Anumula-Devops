output "asg_name" { 
  value = aws_autoscaling_group.app_asg.name 
} 
 
 
Variables.tf  
 
variable "asg_name" { 
  type        = string 
  description = "Name of the Auto Scaling Group" 
} 
 
variable "min_size" { 
  type        = number 
  description = "Minimum size of the ASG" 
} 
 
variable "max_size" { 
  type        = number 
  description = "Maximum size of the ASG" 
} 
 
variable "desired_capacity" { 
  type        = number 
  description = "Desired capacity of the ASG" 
} 
 
variable "private_subnet_ids" { 
  type        = list(string) 
  description = "List of private subnet IDs" 
} 
 
variable "lt_id" { 
  type        = string 
  description = "Launch template ID" 
} 
 
variable "tg_arn" { 
  type        = string 
  description = "Target group ARN" 
} 
