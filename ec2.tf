############################################################
# 1) Дістаємо дефолтну VPC через data "aws_vpc"           #
############################################################
data "aws_vpc" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

############################################################
# 2) Створюємо Security Group для SSH                     #
############################################################
resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow inbound SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
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

############################################################
# 3) Запускаємо EC2 з прив’язкою SG                        #
############################################################
resource "aws_instance" "ubuntu" {
  ami                    = "ami-04542995864e26699"
  instance_type          = "t3.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "MyUbuntuOnT3"
  }
}
