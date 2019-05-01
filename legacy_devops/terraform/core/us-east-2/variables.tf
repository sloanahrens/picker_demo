variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "aws_region" {
  default     = "us-east-2"
  description = "AWS Region"
}

variable "key_name" { }


variable "ip_class_b" {
  description = "Class B number for IP Range in VPC"
  default     = "25"
}

variable "vpn_ami" {}
variable "queue_ami" {}

variable "public_route53_zone_id" {}
