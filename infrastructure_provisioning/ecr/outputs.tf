output "ecr_web_url" {
  value = "${aws_ecr_repository.web.repository_url}"
}

output "ecr_api_url" {
  value = "${aws_ecr_repository.api.repository_url}"
}