resource "aws_ecs_cluster" "ecs_fargate_cluster" {
  name = "${var.env}_ecs_fargate_cluster"
}


