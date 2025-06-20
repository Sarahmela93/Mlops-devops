variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
  default     = "vockey"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 20.04 LTS in us-east-1"
  type        = string
  default     = "ami-02f7c3a0c32f3f59e"
}