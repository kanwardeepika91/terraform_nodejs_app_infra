output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs_fargate_cluster.id
}

output "subnets" {
  value = aws_alb.ecs_fargate_cluster_alb.subnets
}

output "iam_task_exec_arn" {
  value = aws_iam_role.ecs_tasks_execution_role.arn
}

output "alb_dns_url_app" {
  value = aws_alb.ecs_fargate_cluster_alb.dns_name
} 
output "ecr_repo_url" {
  value = aws_ecr_repository.ecr_repo_for_ecs.repository_url
}
