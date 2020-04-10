resource "aws_ecr_repository" "web" {
  name = "cats-web"
}

resource "aws_ecr_repository" "api" {
  name = "cats-api"
}
