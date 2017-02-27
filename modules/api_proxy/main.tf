module "proxy_instance" {
  source = "../instance"

  name = "api_proxy"
  environment = "${var.environment}"
  vpc_id = "${var.vpc_id}"
  num_ssh_security_groups = "3"
  ssh_security_groups = "${list(var.vpn_security_group, var.jenkins_security_group, var.jenkins_slave_security_group)}"
  private_subnets = "${var.private_subnets}"

  num_instances = "${var.num_instances}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.key_name}"
  root_volume_size = "${var.root_volume_size}"
  policy_attachments = "${var.policy_attachments}"
}

resource "aws_security_group_rule" "vpn_in_3128" {
  security_group_id = "${module.proxy_instance.security_group}"
  type = "ingress"
  from_port = 3128
  to_port = 3128
  protocol = "TCP"
  source_security_group_id = "${var.vpn_security_group}"
}

resource "aws_route53_record" "proxy" {
  zone_id = "${var.route53_zone_id}"
  name = "${var.domain_name}"
  type = "A"
  records = ["${module.proxy_instance.instance_ips}"]
  ttl = 300
}


