output "ecr_repo_url" {
  value = aws_ecr_repository.ecr_for_ecs.arn
}