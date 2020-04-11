output "db_instance_address" {
  value = format("\"%s\"", aws_db_instance.cats.address)
}

output "db_username" {
  value = format("\"%s\"", aws_db_instance.cats.username)
}

output "database_name" {
  value = format("\"%s\"", aws_db_instance.cats.name)
}