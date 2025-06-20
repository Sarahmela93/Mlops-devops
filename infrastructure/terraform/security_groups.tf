resource "aws_security_group" "mlops_sg" {
  name        = "mlops_sg"
  description = "Allow SSH, HTTP, API, MLflow ports"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP / API / MLflow / Streamlit (80-8501)
  ingress {
    from_port   = 80
    to_port     = 8501
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 全量出站
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mlops-sg"
  }
}