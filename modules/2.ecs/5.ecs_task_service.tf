# main.tf
resource "aws_ecs_service" "app_service" {
  name            = "app-first-service"     # Name the service
  cluster         = aws_ecs_cluster.ecs_fargate_cluster.id   # Reference the created Cluster
  task_definition = aws_ecs_task_definition.ecs_app_task_def.arn # Reference the task that the service will spin up
  launch_type     = "FARGATE"
  desired_count   = var.container_app_count # Set up the number of containers to 3

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn # Reference the target group
    container_name   = "${var.env}-app-task"
    container_port   = var.containerPort # Specify the container port
  }

  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = true     # Provide the containers with public IPs
    security_groups  = [aws_security_group.ecs_tasks_sg.id] # Set up the security group
  }
}
