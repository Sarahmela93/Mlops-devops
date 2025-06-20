terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["../_credentials/aws_learner_lab_credentials"]
  profile                  = "awslearnerlab"
}