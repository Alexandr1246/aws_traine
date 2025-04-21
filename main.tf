# main.tf
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = file("${path.module}/ssh-key/terraform-key.pub")
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0907c2c90a7d5fb04"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  # ...
}
