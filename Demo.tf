provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARLJIWABV4RD67K4T"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block       = "175.32.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "175.32.0.0/16"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main.id
  security_groups = [aws_security_group.allow_tls.id]


  tags = {
    Name = "my_ec2"
  }
  }

  resource "aws_ebs_volume" "New_Volume" {
  availability_zone = "us-east-1b"
  size              = 40
  type = "gp3"

  tags = {
    Name = "New_Volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "xvdf"
  volume_id   = aws_ebs_volume.New_Volume.id
  instance_id = aws_instance.myec2.id
}


  output "vpc_id" {
    value = aws_vpc.main.id
  }

  output "volume_id" {
    value = aws_ebs_volume.New_Volume.id
  }

