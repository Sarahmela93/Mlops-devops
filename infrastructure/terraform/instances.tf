# API instance
resource "aws_instance" "api_vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name = "mlops-api"
  }
}

# TRAINING instance
resource "aws_instance" "training_vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name = "mlops-training"
  }
}