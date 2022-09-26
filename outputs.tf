output "user_pool_id" {
  value = aws_cognito_user_pool.private_user_pool.id
}

output "user_pool_arn" {
  value = aws_cognito_user_pool.private_user_pool.arn
}

output "admin_client_id" {
  value = aws_cognito_user_pool_client.admin_client.id
}

output "admin_client_secret_arn" {
  value = aws_secretsmanager_secret.admin_client_secret.arn
}

output "public_client_id" {
  value = aws_cognito_user_pool_client.public_client.id
}

output "user_pool_domain" {
  value = aws_cognito_user_pool_domain.domain.domain
}
