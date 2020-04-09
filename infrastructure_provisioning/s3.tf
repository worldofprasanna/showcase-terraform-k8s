resource "aws_s3_bucket" "chart_repository" {
  bucket = "toptal_chart_repo_prasanna"
  acl    = "private"

  tags = {
    Name        = "Toptal Helm Chart Repo"
    Reason = "toptal"
  }
}