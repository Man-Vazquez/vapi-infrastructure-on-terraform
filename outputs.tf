output "bucket_name" {
  value = aws_s3_bucket.vapi.bucket
}

output "iam_user" {
  value = aws_iam_user.vapi.name
}

output "access_key_id" {
  value = aws_iam_access_key.vapi.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.vapi.secret
  sensitive = true
}