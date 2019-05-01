output "App ELB" {
  value = "${aws_alb.app.dns_name}"
}

output "Static S3 Bucket" {
  value = "${aws_s3_bucket.static.bucket}"
}

output "Uploaded S3 Bucket" {
  value = "${aws_s3_bucket.uploaded.bucket}"
}
