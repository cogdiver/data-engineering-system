resource "aws_secretsmanager_secret" "secret" {
  name        = "${var.project_name_base}-secret"
  description = "This is a secret managed by Terraform"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = "${var.project_name_base}-secret-value"
}
