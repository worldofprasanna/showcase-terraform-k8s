resource "aws_s3_bucket" "chart_repository" {
  bucket = "${var.environment}-cats-helm-chart"
  acl    = "private"

  tags = {
    Name        = "Cats Helm Chart Repo"
  }
}