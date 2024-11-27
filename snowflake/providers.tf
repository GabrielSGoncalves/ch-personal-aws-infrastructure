terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.61"
    }
  }
}

provider "snowflake" {
  organization_name = var.snowflake_org
  account_name  = var.snowflake_account
  user     = var.snowflake_user
  password = var.snowflake_password
  role     = "SYSADMIN"
}




