module "api_proxy" {
  source = "../modules/api_proxy"

  environment = "staging"
  vpc_id = "vpc-7c556b1b"
  vpn_security_group = "sg-2d241857"
  jenkins_security_group = "sg-2d241857"
  jenkins_slave_security_group = "sg-2d241857"
  private_subnets = ["subnet-edaa6ab6"]
  route53_zone_id = "${var.route53_zone_id}"

  num_instances = 1
  instance_type = "t1.micro"
  ami = "ami-6002c508"
  key_name = "${var.ssh_key_id}"
  root_volume_size = "8"
  policy_attachments = "${var.all_instance_policy_attachments}"

  domain_name = "test-api-proxy"
}

