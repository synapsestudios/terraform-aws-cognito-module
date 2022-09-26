variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool that we are going to create"
}

variable "admin_client_name" {
  type        = string
  description = "The name of the admin client application to configure"
}

variable "admin_client_secret_name" {
  type        = string
  description = "We store the client secret in secrets manager. This is the name we'll give to the secret in aws secrets manager"
}

variable "admin_client_redirect_uris" {
  type        = list(any)
  description = "List of valid URIs that cognito is allowed to redirect to after authentication is completed."
}

variable "admin_client_logout_urls" {
  type        = list(any)
  description = "List of valid URIs that cognito is allowed to redirect to after logout is complete"
}

variable "public_client_name" {
  type        = string
  description = "The name of the public client application to configure"
}

variable "public_client_redirect_uris" {
  type        = list(any)
  description = "List of valid URIs that cognito is allowed to redirect to after authentication is completed"
}

variable "public_client_logout_urls" {
  type        = list(any)
  description = "List of valid URIs that cognito is allowed to redirect to after logout is complete"
}

variable "domain" {
  type        = string
  description = "The subdomain that our client will use for login and tokens"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the AWS resources"
}

variable "identity_token_expiration" {
  type        = number
  description = "Duration in minutes for the primary identity tokens (id_token and access_token) to remain valid"
  default     = 60
}

variable "aws_region" {
  type        = string
  description = "Specify what region to create resources in"
  default     = "us-west-2"
}

variable "ses_identity_arn" {
  type        = string
  description = "ARN of the SES Domain Identity"
}

variable "from_email_address" {
  type        = string
  description = "No-reply address for system emails"
}

variable "email_sending_account" {
  type        = string
  description = "Account for sending system emails"
  default     = "DEVELOPER"
}

variable "recovery_mechanism_name" {
  type        = string
  description = "Name of recovery method for an account"
  default     = "verified_email"
}

variable "recovery_mechanism_priority" {
  type        = number
  description = "Priority for the recovery mechanisms defined"
  default     = 1
}

variable "allow_admin_create_user_only" {
  type        = bool
  description = "Only admin users can create new users?"
  default     = true
}

variable "invite_message_template_file_path" {
  type        = string
  description = "Path to email template file for inviting new users"
}

variable "invite_message_subject" {
  type        = string
  description = "Subject line for invitation email"
}

variable "invite_sms_message" {
  type        = string
  description = "Text for invitation SMS message"
}

variable "password_minimum_length" {
  type        = number
  description = "Minimum number of characters for passwords"
  default     = 8
}

variable "password_require_lowercase" {
  type        = bool
  description = "Passwords require lowercase characters"
  default     = true
}

variable "password_require_uppercase" {
  type        = bool
  description = "Passwords require uppercase characters"
  default     = true
}

variable "password_require_numbers" {
  type        = bool
  description = "Passwords require numerical characters"
  default     = true
}

variable "password_require_symbols" {
  type        = bool
  description = "Passwords require symbols"
  default     = true
}

variable "temporary_password_validity_days" {
  type        = number
  description = "Number of days a temporary password remains valid"
  default     = 30
}

variable "ui_customization_logo" {
  type        = string
  description = "Path to image file for Cognito user pool UI customization"
}

variable "ui_customization_css" {
  type        = string
  description = "CSS file string for Cognito user pool UI customization"
}
