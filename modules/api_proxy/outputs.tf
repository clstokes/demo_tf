output "security_group_id" { value = "${module.proxy_instance.security_group}" }
output "instance_ips" { value = "${module.proxy_instance.instance_ips}" }
