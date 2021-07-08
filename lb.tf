resource "aws_alb" "application_load_balancer" {
  #vpc_id = module.vpc.vpc_id
  name               = "test-lb-tf" # Naming our load balancer
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  # Referencing the security group
  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
}


resource "aws_lb_target_group" "target_group" {
  name        = "target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group" "blue_group" {
  name        = "blue-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn # Referencing our tagrte group
  }
}

resource "aws_lb_listener" "blue_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn # Referencing our load balancer
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_group.arn # Referencing our tagrte group
  }
}