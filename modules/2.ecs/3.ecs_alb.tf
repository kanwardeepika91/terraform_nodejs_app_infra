# Application load balancer(ALB) creation for ECS
resource "aws_alb" "ecs_fargate_cluster_alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_for_ecs_sg.id]
  #subnets            = [data.aws_subnet.public_subnet_1_cidr.id, data.aws_subnet.public_subnet_2_cidr.id]
  subnets = var.alb_public_subnets
  #subnets = "${var.alb_public_subnets}"

  tags = {
    Name = "${var.env}_ecs_fargate_cluster_alb"
  }
}

# security group to route traffic frm ALB to ECS
resource "aws_security_group" "alb_for_ecs_sg" {
  name        = "${var.env}_alb_sg"
  vpc_id      = var.vpc_id
  description = "security group to route traffic from ALB to ECS"

  tags = {
    Name = "${var.env}_alb_for_ecs_sg"
  }
  ingress { #  allow incoming traffic 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow traffic in from all sources through 80 port
  }

  ingress { #  allow incoming traffic 
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow traffic in from all sources through 80 port
  }
  egress { # allow outgoing traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Target group created for targets (ECS cluster to load balance between tasks)
resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.env}-alb-tg"
  port        = "80"  
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200"
  }
}

resource "aws_alb_listener" "ecs_alb_http_weblistener" {
  load_balancer_arn = aws_alb.ecs_fargate_cluster_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
  depends_on = [aws_alb_target_group.alb_target_group]
}




