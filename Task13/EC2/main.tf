resource "tls_private_key" task13_p_key  {
  algorithm = "RSA"
}


resource "aws_key_pair" "task13-key" {
  key_name    = "task13-key"
  public_key = tls_private_key.task13_p_key.public_key_openssh
  }

  resource "local_file" "private_key" {
  depends_on = [
    tls_private_key.task13_p_key,
  ]
  content  = tls_private_key.task13_p_key.private_key_pem
  filename = "server.pem"
}


resource "aws_instance" "BASTION" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  #subnet_id = var.public_subnet_ids[1]
  subnet_id   = flatten(var.public_subnet_ids)[0]
  vpc_security_group_ids = [var.SG_VPC]

  key_name = "task13-key"

  tags = {
    Name = "bastion_host"
    }
}

resource "aws_instance" "private_host" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  subnet_id   = flatten(var.private_subnet_ids)[0]
  vpc_security_group_ids = [var.SG_VPC]
  key_name = "task13-key"

  tags = {
    Name = "private_host"
    }
}
