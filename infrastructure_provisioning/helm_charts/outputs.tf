output "bucket_arn" {
  value = format("\"%s\"", aws_s3_bucket.chart_repository.bucket_domain_name)
}