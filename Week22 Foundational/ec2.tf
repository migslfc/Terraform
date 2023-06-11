module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["apache1", "apache2"])

  name = each.key
  ami = "ami-04a0ae173da5807d3"
  instance_type = "t2.micro"
  key_name = "my_KeyPair"
  monitoring = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = module.vpc.public_subnets[each.key == "apache1" ? 0 : 1]
  user_data = file("bootstrap.sh")
  associate_public_ip_address = true

  tags = {
    Name = each.key
    Project = "Week22-LastOneBaby"
    Terraform = "true"
  }
}