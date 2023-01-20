data "aws_security_group" "copilot_sg" {
  id = module.copilot_build_aws.aws_security_group.AviatrixCopilotSecurityGroup.security_group_id
}

resource "aws_security_group_rule" "spoke_inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  cidr_blocks       = [for n in local.spoke_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}

resource "aws_security_group_rule" "transit_inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  cidr_blocks       = [for n in local.transit_private_cidrs : n]
  security_group_id = data.aws_security_group.copilot_sg.id
}