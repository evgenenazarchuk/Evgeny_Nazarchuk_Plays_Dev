output "SG_VPC" {
  value       = aws_security_group.only_ssh_bositon.id
  description = "SG id"
}

output "SG_RDS" {
  value       = aws_security_group.rds.id
  description = "SG RDS"
}