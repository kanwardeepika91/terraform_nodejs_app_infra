resource "aws_ecs_task_definition" "ecs_app_task_def" {
  family                   = "${var.env}-app-task" # Name your task
  requires_compatibilities = ["FARGATE"] # use Fargate as the launch type
  network_mode             = "awsvpc"    # add the AWS VPN network mode as this is required for Fargate
  memory                   = var.fargate_memory        # Specify the memory the container requires
  cpu                      = var.fargate_cpu        # Specify the CPU the container requires
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.env}-app-task",
      "image": "${aws_ecr_repository.ecr_repo_for_ecs.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.containerPort},
          "hostPort": ${var.hostPort}
        }
      ],
      "memory": ${var.container_memory},
      "cpu": ${var.container_cpu}
    }
  ]
  DEFINITION
  
}

# load balance from Elastic ip to tasks
resource "aws_security_group" "ecs_tasks_sg" {
  name   = "${var.env}-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = var.containerPort # (6789 container port mapped)
    to_port          = var.containerPort
    security_groups = [aws_security_group.alb_for_ecs_sg.id]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]

  }
}
