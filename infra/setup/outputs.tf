output "cd_user_access_key_id" {
  description = "AWS key ID for continuous deployment (CD) user"
  value       = aws_iam_access_key.cd.id
}

output "cd_user_access_key_secret" {
  description = "AWS key secret for continuous deployment (CD) user"
  value       = aws_iam_access_key.cd.secret
  sensitive   = true
}

output "ecr_repo_static_site" {
  description = "ECR repo url for image which will contain static site"
  value       = aws_ecr_repository.static_site.repository_url
}
