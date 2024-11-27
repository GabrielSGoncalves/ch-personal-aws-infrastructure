resource "aws_vpc" "personal_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "Personal VPC"
    Environment = "Development"
    Project = "personal_iac_terraform"
  }
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.personal_vpc.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = "us-east-1${count.index == 0 ? "a" : "b"}"

  tags = {
    Name = "Public Subnet ${count.index + 1}"
    Project = "personal_iac_terraform"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow PostgreSQL access"
  vpc_id      = aws_vpc.personal_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"] # Allow IPv4
    ipv6_cidr_blocks = ["::/0"] # Allow IPv6
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks  = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "RDS PostgreSQL Security Group"
    Environment = "Development"
    Project = "personal_iac_terraform"
  }
}
