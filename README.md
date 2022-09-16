# terraform-aws-cognito-module
Terraform module for AWS Cognito


## Inputs

### user_pool_name - `string`

The name of the Cognito User Pool to be created

### admin_client_name - `string`

The name of the admin client application to configure

### admin_client_secret_name - `string`

The name of the client secret to be stored in the AWS Secrets Manager. 

### admin_client_redirect_uris - `list(any)`

List of valid URIs that cognito is allowed to redirect to after authentication is completed

### admin_client_logout_urls - `list(any)`

List of valid URIs that cognito is allowed to redirect to after logout is complete

### public_client_name - `string`

The name of the public client application to configure

### public_client_redirect_uris - `list(any)`

List of valid URIs that cognito is allowed to redirect to after authentication is completed.

### public_client_logout_urls - `list(any)`

List of valid URIs that cognito is allowed to redirect to after logout is complete

### domain - `string`

The subdomain that our client will use for login and tokens

### tags - `map(string)`

A mapping of tags to assign to the AWS resources

### identity_token_expiration - `number`

Duration in minutes for the primary identity tokens (`id_token` and `access_token`) to remain valid

Default: 60

### aws_region - `string`

Specify what region to create resources in

Default: us-west-2

### email_sending_account - `string`

Account for sending system emails

### from_email_address - `string`

No-reply address for system emails

### ses_identity_arn - `string`

ARN of the SES Domain Identity

### recovery_mechanism_name - `string`

Name of recovery method for an account

Default = "verified_email"

### recovery_mechanism_priority - `string`

Priority for the recovery mechanisms defined

Default = 1

### allow_admin_create_user_only - `boolean`

Can non-admin users create new application users?"

Default = true

### invite_message_template_file_path - `string`

Path to email template file for inviting new users