provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_security_group" "sg-test" {
  description = "dev_test security group allows ssh for everyone"
  name        = "allow-ssh-${var.tag_name}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jarService" {
  ami = "ami-040ba316fc6ab09df"

  instance_type   = "t2.micro"
  key_name        = "cdp-test"
  security_groups = [aws_security_group.sg-test.name]
 
}

output "security_group" {
  value = [aws_security_group.sg-test.id]
}

output "region" {
  value = var.region
}

output "instanceTags" {
  value = aws_instance.jarService.tags
}

output "jarServiceTags" {
  value = var.tag_name
}

output "dns" {
  value = aws_instance.jarService.public_dns
}
output "vpc" {
  value = aws_instance.jarService.vpc_security_group_ids
}
