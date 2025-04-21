resource "aws_instance" "ubuntu" {
  ami           = "ami-0907c2c90a7d5fb04"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
}