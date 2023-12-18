variable "region" {
  default     = "us-east-1"
  description = "AWS default region"
}

variable "env" {
  default = "dev-ecs"
}
variable "vpc_id" {
}


variable "container_port" {
}

variable "alb_public_subnets" {
}


