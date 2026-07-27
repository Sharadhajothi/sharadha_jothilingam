variable "bucket_name" {
    description = "Name of the S3 bucket"
    type = string
}

variable "environment" {
    description = "Environment for the S3 bucket"
    type = string
    default = "Learning"
}