variable "snowflake_org" {
  description = "Snowflake organization number"
  type        = string
  sensitive   = true
}

variable "snowflake_account" {
  description = "Snowflake account number"
  type        = string
  sensitive   = true
}

variable "snowflake_user" {
  description = "Snowflake user name"
  type        = string
  sensitive   = true
}

variable "snowflake_password" {
  description = "Snowflake password"
  type        = string
  sensitive   = true
}