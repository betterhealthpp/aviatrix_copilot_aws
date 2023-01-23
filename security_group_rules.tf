# Run this file after Copilot has been deployed?

data "aws_security_group" "copilot_sg" {
  depends_on = [
    module.copilot_build_aws
  ]
  name   = "${var.prefix}AviatrixCopilotSecurityGroup"
  vpc_id = var.controller_vpc_id
}

resource "aws_security_group_rule" "controller_inbound" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = [
    "${var.controller_private_ip}/32",
    "${var.controller_public_ip}/32"
  ]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "https_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "udp"
  cidr_blocks       = [for n in var.allowed_cidrs_https : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "spoke_netflow_inbound" {
  type              = "ingress"
  from_port         = 31283
  to_port           = 31283
  protocol          = "udp"
  cidr_blocks       = [for n in local.spoke_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "spoke_syslog_inbound" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "udp"
  cidr_blocks       = [for n in local.spoke_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "transit_netflow_inbound" {
  type              = "ingress"
  from_port         = 31283
  to_port           = 31283
  protocol          = "udp"
  cidr_blocks       = [for n in local.transit_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "transit_syslog_inbound" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "udp"
  cidr_blocks       = [for n in local.transit_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}
