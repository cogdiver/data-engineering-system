# Create a Security Group for the RDS instance
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name_base}_sg_rds"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as necessary for security
  }
}

# Create the RDS instance
resource "aws_db_instance" "rds_db" {
  db_name                = "${var.project_name_base}Database"
  identifier             = "${var.project_name_base}-rds-database"
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres16"
  skip_final_snapshot    = true
  publicly_accessible    = true # false to production
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Adjust the backup and maintenance settings as necessary
  backup_retention_period = 7
  backup_window           = "03:00-06:00" # Minimum 30min
  maintenance_window      = "Mon:00:00-Mon:03:00"

  # Optionally enable multi-AZ deployment
  multi_az = false # true for HA
}
