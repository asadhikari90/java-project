#Security Group
resource "aws_security_group" "pvt_sg" {
  name        = var.security_group_name
  description = "${var.security_group_name} group managed by Terraform"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.tag_name_value
  }
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All egress traffic"
  security_group_id = aws_security_group.pvt_sg.id
}
resource "aws_security_group_rule" "tcp" {
  count                    = var.from_ports == "default_null" ? 0 : length(split(",", var.to_ports))
  type                     = "ingress"
  from_port                = element(split(",", var.from_ports), count.index)
  to_port                  = element(split(",", var.to_ports), count.index)
  protocol                 = "tcp"
  cidr_blocks              = var.cidrblocks
  description              = ""
  security_group_id        = aws_security_group.pvt_sg.id
}