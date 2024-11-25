# Using Hashicorp Terraform for defining IaC in AWS
In order to start using Terraform as IaC tool to define AWS infrastructure, we first need to make sure we have a proper local setup.

## Creating a service account for Terraform
The first step is to create a service account user for Terraform, using the AWS CLI:
```bash
aws iam create-user --user-name terraform-service-account
```
Next, we need to create policy for this service account to access the main AWS services we are going to use to build our infrastructure:
```bash
aws iam create-policy --policy-name TerraformServiceAccountPolicy --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "vpc:*",
                "s3:*",
                "iam:*",
                "glue:*",
                "rds:*",
                "kinesis:*"
                "secretsmanager:*"
            ],
            "Resource": "*"
        }
    ]
}'
```
Attach this policy to Terraform service account. Make sure to copy the ARN from the output of the last command to one bellow:
```bash
aws iam attach-user-policy --user-name terraform-service-account --policy-arn arn:aws:iam::823508979989:policy/TerraformServiceAccountPolicy
```
And finnaly generate the access keys for this service account:
```bash
aws iam create-access-key --user-name terraform-service-account
```
You'll use the output from the previous command to define the credentials for Terraform to access AWS.

## Storing secrets and creating Terraform variables
With the Terraform AWS service account created and the access and secret keys, we need to configure it so Terraform can use it. Create the `terraform.tfvars` file and add the information about the service account as described bellow:
```text
aws_access_key = "your-access-key"
aws_secret_key = "your-secret-key"
aws_region     = "us-east-1"
```

Remember that both `aws_access_key` and `aws_secret_key` are sensitive information, so make sure to add the file to your `.gitignore`.

For Terraform to use the define local variables, you need to created a `variables.tf` file with the following structure:
```text
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
```
And finally, in your `providers.tf` file, you can call the defined variables:
```text
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```
Now we are ready to start using Terraform to build AWS infrastructure.




