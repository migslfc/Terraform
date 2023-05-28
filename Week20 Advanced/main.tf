# EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  tags = {
    "Name" = "Jenkins-Advanced"
  }

  # VPC and Subnet Configuration
  subnet_id = var.subnet_id

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
  name        = var.jenkins_sg_name
  description = var.jenkins_sg_description

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_ip_cidr_block]
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
  bucket = var.jenkins_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "jenkins_artifacts_bucket_owner_controls" {
  bucket = aws_s3_bucket.jenkins_artifacts_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
