variable "region" {
  default     = "us-east-1"
  description = "AWS default region"
}

variable "env" {
  default = "dev-ecs"
}
variable "vpc_id" {
}



variable "alb_public_subnets" {
  type = list(any)
}


variable "fargate_memory" {
  type = number
}

variable "fargate_cpu" {
  type = number
}

variable "containerPort" { 
type = number
}

variable "hostPort" { 
type = number
}

variable "container_memory" {
  type = number
}

variable "container_cpu" {
  type = number
}

variable "container_app_count" { 
  type = number
  default = 2
}

variable "private_subnets" {
  
}

