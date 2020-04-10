# Create RDS
resource "aws_db_instance" "cats" {
  identifier             = "cats"
  allocated_storage      = "${var.storage}"
  engine                 = "postgres"
  engine_version         = "12.2"
  instance_class         = "${var.instance_class}"
  name                   = "catsdb"
  username               = "${var.username}"
  password               = "${var.password}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.cats.id}"
  skip_final_snapshot    = "true"
}

resource "aws_db_subnet_group" "cats" {
  name        = "cats"
  description = "Subnet group for RDS"
  subnet_ids  = ["${var.private_subnet1_id}", "${var.private_subnet2_id}"]
}
