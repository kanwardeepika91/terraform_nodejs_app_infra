terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  required_version = "v1.5.7"
  }
}

  backend "s3" {
    key    = "DEV/ecs_infra_setup.tfstate"
    bucket = "ecs-infra-state-devops"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}