output "bucket_name" {
  value = aws_s3_bucket.uitgo_bucket.id
}

output "bucket_arn" {
    value = aws_s3_bucket.uitgo_bucket.arn
}