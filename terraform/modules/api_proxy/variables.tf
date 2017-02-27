variable "environment" {}
variable "vpc_id" {}
variable "vpn_security_group" {}
variable "jenkins_security_group" {}
variable "jenkins_slave_security_group" {}
variable "route53_zone_id" {}

variable "domain_name" {
  description = "DNS record to map to the instance."
}

variable "num_instances" {
  default = 1
}
variable "instance_type" {}
variable "ami" {}
variable "key_name" {}
variable "private_subnets" {
  type = "list"
}
variable "root_volume_size" {}
variable "policy_attachments" {
  description = "List of ARNs for policies that should be attached to the instance profile"
  type = "list"
  default = []
}
