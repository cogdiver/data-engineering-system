# Create a security group to allow access to Redshift
resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Allow Redshift access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to the appropriate IP or range
  }
}

# Create a Redshift Serverless namespace
resource "aws_redshiftserverless_namespace" "redshift_namespace" {
  namespace_name      = "${var.project_name_base}-namespace"
  admin_username      = var.db_username
  admin_user_password = var.db_password
  db_name             = "${var.project_name_base}_redshift"
}

# Create a Redshift Serverless workgroup
resource "aws_redshiftserverless_workgroup" "redshift_workgroup" {
  workgroup_name    = "${var.project_name_base}-workgroup"
  namespace_name    = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
  base_capacity     = 8  # Set the base capacity in Redshift Processing Units (RPUs)

  security_group_ids = [aws_security_group.redshift_sg.id]
  publicly_accessible = true  # Change to false if public access is not required
}
