

resource "aws_launch_configuration" "launch-config" {
  name          = "tf-launch-config"
  image_id      = var.ami_id
  instance_type = var.instance_type

  security_groups = [aws_security_group.asg_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum -y install httpd
                sudo service httpd start  
                sudo chkconfig httpd on   
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.launch-config.name
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.min_size

  vpc_zone_identifier = var.subnet_ids

  lifecycle {
    create_before_destroy = true
  }
}
