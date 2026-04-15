provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "my-backend-bucket1229"
}

resource "aws_dynamodb_table" "my_table" {
    name           = "my-backend-table"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}