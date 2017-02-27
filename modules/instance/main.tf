resource "aws_iam_role" "default" {
  name = "${var.environment}-${var.name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "default" {
  count = "${length(var.policy_attachments)}"
  role = "${aws_iam_role.default.name}"
  policy_arn = "${element(var.policy_attachments, count.index)}"
}

resource "aws_iam_instance_profile" "default" {
  name = "${var.environment}-${var.name}"
  roles = ["${aws_iam_role.default.name}"]
}

resource "aws_security_group" "default" {
  name = "${var.environment}-${var.name}"
  description = "${var.environment} ${var.name}"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.environment} ${var.name}",
    owner = "terraform",
    environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "in_ssh" {
  count = "${var.num_ssh_security_groups}"
  security_group_id = "${aws_security_group.default.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "TCP"
  source_security_group_id = "${element(var.ssh_security_groups, count.index)}"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = "${aws_security_group.default.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "default" {
  count = "${var.num_instances}"

  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.key_name}"
  subnet_id = "${element(var.private_subnets, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.default.name}"

  root_block_device = {
    volume_size = "${var.root_volume_size}"
  }

  tags {
    Name = "${var.name}-${var.environment}-${count.index}",
    role = "${var.name}",
    owner = "terraform",
    environment = "${var.environment}",
    auto = "${var.environment}-${var.name}",
    payment = "${var.environment}"
  }
}
