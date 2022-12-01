variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.11.0/24",
    "10.0.22.0/24",
    "10.0.33.0/24"
  ]
}

variable "database_subnet_cidrs" {
  default = [
    "10.0.21.0/24",
    "10.0.32.0/24",
    "10.0.43.0/24"
  ]
}