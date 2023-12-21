output "ecr_repo_url" {
  value = aws_ecr_repository.ecr_repo_for_ecs.repository_url
}
