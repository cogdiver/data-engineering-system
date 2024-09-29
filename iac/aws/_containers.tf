# Create the ECR repositories
resource "aws_ecr_repository" "repo" {
  name         = "${var.project_name_base}_repo"
  force_delete = true
}

# Create the ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name  = "${var.project_name_base}_cluster"
}
