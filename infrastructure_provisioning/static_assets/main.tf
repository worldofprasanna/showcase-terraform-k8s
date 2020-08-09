resource "aws_s3_bucket" "cats" {
    bucket = "${var.assets_bucket_name}"
    acl = "public-read"

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.assets_bucket_name}/*"
        }
    ]
}
EOF
}

locals {
  s3_origin_id = "s3-${var.assets_bucket_name}"
}

resource "aws_cloudfront_distribution" "cats-distribution" {
    origin {
      domain_name = "${aws_s3_bucket.cats.bucket_regional_domain_name}"
      origin_id   = "${local.s3_origin_id}"

      s3_origin_config {
        origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
      }
    }
    default_root_object = "index.html"
    enabled             = true

    custom_error_response {
        error_caching_min_ttl = 3000
        error_code            = 404
        response_code         = 200
        response_page_path    = "/index.html"
    }

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.cats.bucket}"

        forwarded_values {
            query_string = true

            cookies {
                forward = "none"
            }
      }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    # Restricts who is able to access this content
    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none
            restriction_type = "none"
        }
    }

    # SSL certificate for the service.
    viewer_certificate {
        cloudfront_default_certificate = true
    }
}