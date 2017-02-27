variable "ssh_key_id" {
  default = "staging_vpc_0816"
}
variable "route53_zone_id" {
  default = "Z2AX16QPAN3CV9" # bcdtriptech.com
}
variable "golden_image_ami" {
  default = "ami-c1f515acasa"
}
variable "bcdtriptech_wildcard_cert" {
  default = "arn:aws:acm:us-east-1:076263846157:certificate/211df695-c599-4f03-8f52-bd2b0649f078"
}
variable "staging_bcdtriptech_wildcard_cert" {
  default = "arn:aws:acm:us-east-1:076263846157:certificate/f47f53b7-d998-4072-b933-19dd98037069"
}
variable "all_instance_policy_attachments" {
  description = "List of ARNs for externally managed policies that should be attached to each instance profile"
  type = "list"
  default = [
    "arn:aws:iam::076263846157:policy/gg_tags_access",
    "arn:aws:iam::076263846157:policy/gg_non_prod_cloud_init_access"
  ]
}
