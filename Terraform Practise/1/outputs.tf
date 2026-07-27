output "bucket_arn"{
    value =aws_s3_bucket.my_bucket.arn
}

output "account_id"{
    value =data.aws_caller_identity.current.account_id
}