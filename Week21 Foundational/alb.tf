
# WEEK21 PROJECT ADVANCED


resource "aws_alb" "alb" {
  name               = "wk21-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids
}

resource "aws_alb_target_group" "alb_tg" {
  name     = "wk21-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "as_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn      = aws_alb_target_group.alb_tg.arn
}

