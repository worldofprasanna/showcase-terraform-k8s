output "ecr_web_url" {
  value = format("\"%s\"", aws_ecr_repository.web.repository_url)
}

output "ecr_api_url" {
  value = format("\"%s\"", aws_ecr_repository.api.repository_url)
}