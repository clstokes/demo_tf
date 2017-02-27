output "security_group" { value = "${aws_security_group.default.id}" }
output "instance_ids" { value = ["${aws_instance.default.*.id}"] }
output "instance_ips" { value = ["${aws_instance.default.*.private_ip}"] }
output "instance_policy" { value = "${aws_iam_role.default.name}" }
output "instance_subnets" { value = ["${aws_instance.default.*.subnet_id}"] }
output "instance_availability_zones" { value = ["${aws_instance.default.*.availability_zone}"] }
