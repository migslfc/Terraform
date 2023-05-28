# Provider Configuration
provider "aws" {
  region = "us-east-1" # desired region
}

# EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0bef6cc322bfff646" # HVM edition of the Amazon Linux AMI
  instance_type = "t2.micro"
  key_name      = "gold-luit-kp" # key pair name without .pem extension
  tags = {
    "Name" = "Jenkins-Foundational"
  }


  # VPC and Subnet Configuration
  subnet_id = "subnet-00adf964199122c5c" # subnet within my Default VPC

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id] #associate with security group created

  # Bootstrap Script for Jenkins image
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo amazon-linux-extras enable corretto8
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    EOF
}

# Security Group for Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security Group for Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["99.85.64.215/32"] # public IP address on your machine
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3 Bucket for Jenkins Artifacts
resource "aws_s3_bucket" "jenkins_artifacts_bucket" {
  bucket = "jenky-af-bucket" # desired bucket name

}

resource "aws_s3_bucket_ownership_controls" "jenkins_artifacts_bucket_owner_controls" {
  bucket = aws_s3_bucket.jenkins_artifacts_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
