data "aws_caller_identity" "current" {}

resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name
  auto_verified_attributes = ["phone_number"]

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers = true
    require_symbols = true
    require_uppercase = true
  }
  
  mfa_configuration = "OPTIONAL"
  sms_configuration {
    external_id    = "cognito-sms"
    sns_caller_arn = var.cognito_sms_role_arn
    }
}

resource "aws_cognito_user_pool_client" "this" {
  name = var.app_client_name
  user_pool_id = aws_cognito_user_pool.this.id
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"

}