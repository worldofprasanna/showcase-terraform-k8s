output "sg_for_db" {
  value = "${aws_security_group.db.id}"
}

output "sg_for_web" {
  value = "${aws_security_group.web.id}"
}

output "private_subnet1" {
  value = "${aws_subnet.private1.id}"
}

output "private_subnet2" {
  value = "${aws_subnet.private2.id}"
}

output "public_subnet" {
  value = "${aws_subnet.public.id}"
}