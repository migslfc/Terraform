

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Default VPC ID"
  default     = "vpc-07432a36252a56761"
}

variable "subnet_ids" {
  description = "Default Subnet IDs"
  type        = list(string)
  default     = ["subnet-1a2b3c4d", "subnet-4d3c2b1a"] # your subnet IDs
}

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-012e27fc97c46993d" # amazon Linux AMI
}

variable "instance_type" {
  description = "Instance Type"
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum number of instances"
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances"
  default     = 5
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "week21-state-mc" # your bucket name
}

# WEEK21 PROJECT ADVANCED

variable "alb_security_group_name" {
  description = "Name of the ALB security group"
  default     = "alb_sg" # your ALB sg name
}

variable "autoscaling_group_security_group_name" {
  description = "Name of the autoscaling group security group"
  default     = "asg_sg" # your ASG sg name
}
