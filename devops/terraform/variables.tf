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

//

variable "stack_name" {
  default     = "production"
  description = "Stack Name"
}

variable "app_instance_size" {
  default = "t2.micro"
}

variable "worker_instance_size" {
  default = "t2.micro"
}

variable "ubuntu_amis" {
  type = "map"
  default = {
    "us-east-2" = "ami-8b92b4ee"
  }
}

variable "ip_class_b" {
  description = "Class B number for IP Range in VPC"
  default     = "25"
}

variable "app_ami" {}
variable "worker_ami" {}

// 

variable "public_route53_zone_id" {}

variable "master_vpc_id" {}

variable "app_public_subnet_b_id" {}
variable "app_public_subnet_c_id" {}

variable "app_private_subnet_id" {}


variable "ssl_certificate" {}