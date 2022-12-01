resource "aws_db_option_group" "option_group" {
  name                 = "${var.envirement_name}-option-group"
  engine_name          = "mysql"
  major_engine_version = var.engine_version_mysql

}

resource "aws_db_parameter_group" "parameter_group" {
  name   = "${var.envirement_name}-parameter-group"
  family = "mysql8.0"
}


resource "aws_db_instance" "rds_mysql" {
  instance_class          = var.instance_class
  allocated_storage       = 10
  engine                  = var.engine
  engine_version          = var.engine_version_mysql
  username                = var.username_mysql
  password                = random_password.database_password.result
  db_name                 = var.name_database
  db_subnet_group_name    = flatten(var.database_subnet_ids)[2]
  vpc_security_group_ids  = [var.SG_RDS]
  parameter_group_name    = aws_db_parameter_group.parameter_group.name
  maintenance_window      = var.maintenance_window
  skip_final_snapshot     = true
  publicly_accessible     = true
  backup_retention_period = 0
}


resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = jsonencode(
    {
      password = random_password.database_password.result
      username = aws_db_instance.rds_mysql.username
    }
  )
}

resource "random_password" "database_password" {
  length  = 16
  special = false

}

# resource "aws_secretsmanager_secret" "password" {
#   name = "dev/rds"

# }
