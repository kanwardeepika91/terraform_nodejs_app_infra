resource "aws_ecr_repository" "ecr_for_ecs" {
  name = "${var.env}_ecr"
  image_tag_mutability = "MUTABLE" # to put the latest tag on most recent image
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "${var.env}-ecr"
  }
}