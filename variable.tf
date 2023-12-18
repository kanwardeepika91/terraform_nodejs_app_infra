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

variable "container_port" {

}
