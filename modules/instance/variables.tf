variable "name" {}
variable "environment" {}
variable "vpc_id" {}
variable "num_ssh_security_groups" {}
variable "ssh_security_groups" {
  type = "list"
  description = "Security groups that should be allowed to connect via SSH"
}

variable "num_instances" {}
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
