resource "aws_security_group" "subnetSG" {
  name        = "SubnetSG"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "TCP from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      "ipv6_cidr_blocks" : null,
      "prefix_list_ids" : null,
      "security_groups" : null,
      "self" : null,
    },
 {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      "ipv6_cidr_blocks" : null,
      "prefix_list_ids" : null,
      "security_groups" : null,
      "self" : null,
    },
{
      description      = "HTTP from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      "ipv6_cidr_blocks" : null,
      "prefix_list_ids" : null,
      "security_groups" : null,
      "self" : null,
    }
  ]

  egress = [
    {
      description      = "All from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      "ipv6_cidr_blocks" : null,
      "prefix_list_ids" : null,
      "security_groups" : null,
      "self" : null,
    }
  ]

  tags = {
    Name = "Allow all-security_group"
  }
}

resource "aws_security_group" "only_ssh_bositon" {
  name        = "only_ssh_bositon"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "Bastion-security_group"
  }
}


resource "aws_security_group" "rds" {
  name   = "RDS-security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-security_group"
  }
}
