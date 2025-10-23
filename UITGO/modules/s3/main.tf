resource "aws_s3_bucket" "uitgo_bucket" {
  bucket = "${var.project_name}-assets"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.uitgo_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  
}

data "aws_iam_policy_document" "bucket_policy" {
    statement {
      sid = "AllowUserServiceAccess"
      effect = "Allow"
      principals {
        type = "AWS"
        identifiers = [var.user_service_role_arn]
      }
      actions = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]

      resources = [
        "${aws_s3_bucket.uitgo_bucket.arn}/users/*"
      ]
    }

    statement {
      sid = "AllowDriverServiceAccess"
      effect = "Allow"
      principals {
        type = "AWS"
        identifiers = [ var.driver_service_role_arn ]
      }
      actions = [ "s3:PutObject", "s3:GetObject", "s3:DeleteObject" ]

      resources = [
        "${aws_s3_bucket.uitgo_bucket.arn}/drivers/*"
      ]
    }
    
    
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.uitgo_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}