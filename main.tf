provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "petclinic" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"

  key_name = "petclinic-keypair"

  security_groups = ["petclinic-sg"]

  tags = {
    Name = "PetClinic-Server"
  }
}

output "public_ip" {
  value = aws_instance.petclinic.public_ip
}