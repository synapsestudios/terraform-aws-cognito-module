provider "aws" {
    region = var.aws_region
}

resource "aws_cognito_user_pool" "private_user_pool" {

  name = var.user_pool_name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  email_configuration {
    email_sending_account = var.email_sending_account
    from_email_address    = var.from_email_address
    source_arn            = var.ses_identity_arn
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = var.recovery_mechanism.name
      priority = var.recovery_mechanism.priority
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only
    invite_message_template {
      email_message = file(var.invite_message_template_file_path)
      email_subject = var.invite_message_subject
      sms_message = var.invite_sms_message
    }
  }

  password_policy {
    minimum_length = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers = var.password_require_numbers
    require_symbols = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  tags = merge(var.tags, { name = var.user_pool_name })
}

resource "aws_cognito_user_pool_client" "admin_client" {
  name         = var.admin_client_name
  user_pool_id = aws_cognito_user_pool.private_user_pool.id

  generate_secret                      = true
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  callback_urls                        = var.admin_client_redirect_uris
  logout_urls                          = var.admin_client_logout_urls
  allowed_oauth_scopes                 = ["openid", "profile"]
  supported_identity_providers         = ["COGNITO"]
  id_token_validity                    = var.identity_token_expiration
  access_token_validity                = var.identity_token_expiration

  token_validity_units {
    id_token = "minutes"
    access_token = "minutes"
  }

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.private_user_pool.id
}

resource "aws_secretsmanager_secret" "admin_client_secret" {
  name        = var.admin_client_secret_name
  description = "holds the client secret for the ${var.admin_client_name} cognito client application"

  tags = merge(var.tags, {
    name = "${var.admin_client_name} client secret store"
  })
}

resource "aws_secretsmanager_secret_version" "admin_client_secret_value" {
  secret_id     = aws_secretsmanager_secret.admin_client_secret.id
  secret_string = aws_cognito_user_pool_client.admin_client.client_secret
}

resource "aws_cognito_user_pool_client" "public_client" {
  name         = var.public_client_name
  user_pool_id = aws_cognito_user_pool.private_user_pool.id

  generate_secret                      = false
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  callback_urls                        = var.public_client_redirect_uris
  logout_urls                          = var.public_client_logout_urls
  allowed_oauth_scopes                 = ["openid", "profile"]
  supported_identity_providers         = ["COGNITO"]
  id_token_validity                    = var.identity_token_expiration
  access_token_validity                = var.identity_token_expiration

  token_validity_units {
    id_token = "minutes"
    access_token = "minutes"
  }

  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]
}

resource "aws_cognito_user_pool_ui_customization" "custom_css" {
  client_id = aws_cognito_user_pool_client.admin_client.id
  user_pool_id = aws_cognito_user_pool_domain.domain.user_pool_id
  image_file = filebase64(var.ui_customization_logo)
  css = var.ui_customization_css
}

