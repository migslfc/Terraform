variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0bef6cc322bfff646"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the key pair for SSH access"
  default     = "gold-luit-kp"
}

variable "subnet_id" {
  description = "ID of the subnet within the default VPC"
  default     = "subnet-00adf964199122c5c"
}

variable "public_ip_cidr_block" {
  description = "CIDR block of the public IP address on your machine"
  default     = "99.85.64.215/32"
}

variable "jenkins_bucket_name" {
  description = "Name of the Jenkins artifacts bucket"
  default     = "jenky-af-adv-bucket"
}

variable "jenkins_sg_name" {
  description = "Name of the Jenkins security group"
  default     = "jenkins-adv-sg"
}

variable "jenkins_sg_description" {
  description = "sg allowing inbound port22 and 8080. outbound 443."
  default     = "Security Group for Jenkins"
}
