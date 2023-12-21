variable "region" {
  default     = "us-east-1"
  description = "AWS default region"
}

variable "env" {
  default = "dev_ecs"
}
variable "vpc_cidr" {
  description = "vpc cidr block range value will be passed as tfvars"
}

variable "containerPort" { }

variable "hostPort" { }

variable "fargate_memory" {
  type = number
}

variable "fargate_cpu" {
  type = number
}

variable "container_memory" {
  type = number
}

variable "container_cpu" {
  type = number
}