terraform {
  backend "s3" {
    bucket = "petclinic-tfstate-bucket123"
    key    = "petclinic/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

resource "aws_security_group" "petclinic_sg" {
  name        = "petclinic-sg"
  description = "Security group for PetClinic"

  ingress {
    description = "SSH from Terraform runner"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${trimspace(data.http.my_ip.response_body)}/32"]
  }

  ingress {
    description = "App port"
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "petclinic" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"

  key_name               = "petclinic-keypair"
  vpc_security_group_ids = [aws_security_group.petclinic_sg.id]

  tags = {
    Name = "PetClinic-Server"
  }
}

output "public_ip" {
  value = aws_instance.petclinic.public_ip
}
