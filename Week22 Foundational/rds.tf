module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "week22-rds"
  
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t2.micro"
  allocated_storage = 5
  
  name     = "week22-rds"
  username = var.db_username
  password = var.db_password
  port     = "3306"

  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  subnet_ids           = module.vpc.private_subnet_ids

  skip_final_snapshot = true
  
  tags = {
    Name = "week22-rds"
    Project = "Week22-LastOneBaby"
    Terraform = "true"
  }
}
