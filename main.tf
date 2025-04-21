resource "aws_instance" "ubuntu" {
  ami           = "ami-04542995864e26699"
  instance_type = "t3.micro"
  key_name      = "terraform-key"
}