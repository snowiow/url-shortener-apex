variable "apex_function_shorten" {}

variable "apex_function_names" {
  type = "map"
}

variable "region" {
  description = "The region to deploy into"
  type        = "string"
}

variable "account" {
  description = "The account ID to be deployed on"
  type        = "string"
}

provider "aws" {
  region  = "${var.region}"
  version = "1.57"
}
