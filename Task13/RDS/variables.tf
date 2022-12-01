variable "instance_class" {
  default = "db.t3.micro"

}

variable "maintenance_window" {
  default = "Fri:00:00-Fri:01:00"
}

variable "envirement_name" {
  default = "dev"
}

variable "namedb" {
  default = "devrds"
}

variable "engine_version_mysql" {
  default = "8.0"

}

variable "username_mysql" {
  default = "devops"

}

variable "engine" {
  default = "mysql"
}


variable "name_database" {
  default = "devrds"
}

variable "SG_RDS" {
    
}

variable "database_subnet_ids" {
    
}