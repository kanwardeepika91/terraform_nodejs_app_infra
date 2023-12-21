resource "aws_ecr_repository" "ecr_repo_for_ecs" {
  name = "${var.env}-ecr"
  image_tag_mutability = "MUTABLE" # to put the latest tag on most recent image
  force_delete = true #### isnot working. use below command to delete manually
  #aws ecr delete-repository --repository-name dev-ecs-ecr --force --region us-east-1
  image_scanning_configuration {
  scan_on_push = true
  }
  tags = {
    Name = "${var.env}-ecr"
  }
}