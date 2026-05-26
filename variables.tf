variable "region" {
  type        = string
  description = "AWS region where all resources will be provisioned."
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "Name tag used to look up the existing VPC created by the setup workspace."
  default     = "mediastream-vpc"
}

variable "instance_name" {
  type        = string
  description = "Name tag used to look up the existing EC2 instance created by the setup workspace."
  default     = "mediastream-api"
}

variable "listener_port" {
  type        = number
  description = "Port on which the ALB listener accepts incoming HTTP traffic."
  default     = 80
}

variable "environment" {
  type        = string
  description = "Deployment environment label (e.g. dev, staging, production)."
}
