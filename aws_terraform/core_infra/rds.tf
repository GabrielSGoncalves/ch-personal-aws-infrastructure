data "aws_secretsmanager_secret" "postgres_credentials" {
  name = "dev/rds/postgres-test"
}

data "aws_secretsmanager_secret_version" "postgres_credentials" {
  secret_id = data.aws_secretsmanager_secret.postgres_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.postgres_credentials.secret_string)
}

resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group"
  subnet_ids = [aws_subnet.public[0].id, aws_subnet.public[1].id]

  tags = {
    Name        = "Postgres Subnet Group"
    Environment = "Development"
    Project     = "personal_iac_terraform"
  }
}


resource "aws_db_instance" "postgres" {
  identifier        = "personal-postgres-db"
  engine            = "postgres"
  engine_version    = "16.3"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  username = local.db_credentials["username"]
  password = local.db_credentials["password"]

  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name        = "Personal Postgres Database"
    Environment = "Development"
    Project     = "personal_iac_terraform"
  }
}