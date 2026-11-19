output "user_pool_id" {
  description = "ID of the Cognito user pool."
  value       = aws_cognito_user_pool.private_user_pool.id
}

output "user_pool_arn" {
  description = "ARN of the Cognito user pool."
  value       = aws_cognito_user_pool.private_user_pool.arn
}

output "admin_client_id" {
  description = "ID of the admin app client."
  value       = aws_cognito_user_pool_client.admin_client.id
}

output "admin_client_secret_arn" {
  description = "ARN of the Secrets Manager secret that holds the admin app client secret."
  value       = aws_secretsmanager_secret.admin_client_secret.arn
}

output "public_client_id" {
  description = "ID of the public app client. This client has no secret."
  value       = aws_cognito_user_pool_client.public_client.id
}

output "user_pool_domain" {
  description = "Domain prefix of the user pool's hosted UI."
  value       = aws_cognito_user_pool_domain.domain.domain
}
