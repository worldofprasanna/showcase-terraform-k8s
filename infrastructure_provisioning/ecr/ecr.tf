resource "aws_ecr_repository" "web" {
  name = "${var.environment}-cats-web"
}

resource "aws_ecr_repository" "api" {
  name = "${var.environment}-cats-api"
}
