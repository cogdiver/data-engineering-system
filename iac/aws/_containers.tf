# Create the ECR repositories
resource "aws_ecr_repository" "server_repo" {
  name         = "${var.project_name_base}_repo"
  force_delete = true
}
