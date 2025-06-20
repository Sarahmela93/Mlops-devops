provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["../_credentials/aws_learner_lab_credentials"]
  profile                  = "awslearnerlab"
}

resource "aws_security_group" "mlops_sg" {
  name        = "mlops_sg"
  description = "Allow SSH, HTTP, API, MLflow ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 8501
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "api_vm" {
  ami                    = "ami-02f7c3a0c32f3f59e"  
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name = "mlops-api"
  }
}

resource "aws_instance" "training_vm" {
  ami                    = "ami-02f7c3a0c32f3f59e"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name = "mlops-training"
  }
}

output "api_instance_ip" {
  value = aws_instance.api_vm.public_ip
}

output "training_instance_ip" {
  value = aws_instance.training_vm.public_ip
}