output "db_security_group_id" {
  value = format("\"%s\"", aws_security_group.db.id)
}

output "web_security_group_id" {
  value = format("\"%s\"", aws_security_group.web.id)
}

output "private_subnet1_id" {
  value = format("\"%s\"", aws_subnet.private1.id)
}

output "private_subnet2_id" {
  value = format("\"%s\"", aws_subnet.private2.id)
}

output "public_subnet1_id" {
  value = format("\"%s\"", aws_subnet.public1.id)
}

output "public_subnet2_id" {
  value = format("\"%s\"", aws_subnet.public2.id)
}

output "vpc_id" {
  value = format("\"%s\"", aws_vpc.cats.id)
}