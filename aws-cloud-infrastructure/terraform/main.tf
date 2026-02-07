provider "aws" { 
region = var.region 
} 
# Create VPC 
resource "aws_vpc" "main" { 
cidr_block = var.vpc_cidr 
tags = { Name = "tf-vpc" } 
} 
# Internet Gateway 
resource "aws_internet_gateway" "igw" { 
vpc_id = aws_vpc.main.id 
} 
# Public subnets 
resource "aws_subnet" "public" { 
count            
       = 
vpc_id                 
length(var.public_subnet_cidrs) 
 = aws_vpc.main.id 
cidr_block       
       = 
var.public_subnet_cidrs[count.index] 
map_public_ip_on_launch = true 
availability_zone       = element(data.aws_availability_zones.available.names, count.index) 
} 
data "aws_availability_zones" "available" {} 
# Route Table 
resource "aws_route_table" "public" { 
vpc_id = aws_vpc.main.id 
route { 
cidr_block = "0.0.0.0/0" 
gateway_id = aws_internet_gateway.igw.id 
} 
} 
resource "aws_route_table_association" "public" { 
count  
        = 
subnet_id   
length(var.public_subnet_cidrs) 
   = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public.id 
} 
 
# Security Groups 
module "security_groups" { 
  source = "./modules/security-groups" 
  vpc_id = aws_vpc.main.id 
} 
 
  instance_type = var.instance_type 
  key_name      = var.key_name 
 
  user_data = base64encode(<<-EOT 
              #!/bin/bash 
              yum update -y 
              amazon-linux-extras install -y nginx1 
              systemctl enable nginx 
              systemctl start nginx 
              echo "<h1>Welcome to Terraform ASG + ALB Demo 🚀</h1>" > /usr/share/nginx/html/index.html 
              EOT 
  ) 
 
  network_interfaces { 
    security_groups = [module.security_groups.instance_sg_id] 
  } 
 
  iam_instance_profile { 
    name = module.iam.instance_profile 
  } 
 
  lifecycle { 
    create_before_destroy = true 
  } 
} 
 
# Auto Scaling Group 
resource "aws_autoscaling_group" "app_asg" { 
  desired_capacity    = var.desired_capacity 
  min_size            = var.min_size 
  max_size            = var.max_size 
  vpc_zone_identifier = aws_subnet.public[*].id 
  health_check_type   = "EC2" 
 
  launch_template { 
    id      = aws_launch_template.app_lt.id 
    version = "$Latest" 
  } 
 
  target_group_arns = [module.alb.target_group_arn] 
 
  tag { 
    key                 = "Name" 
    value               = "app-instance" 
    propagate_at_launch = true 
  } 
} 
