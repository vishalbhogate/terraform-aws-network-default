resource aws_network_acl "secure" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.secure.*.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-ACL-Secure"
      "Scheme"  = "secure"
      "EnvName" = var.name
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}


###########
# EGRESS
###########

resource aws_network_acl_rule "out_secure_to_secure" {
  count          = length(aws_subnet.secure.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = true
  rule_number    = count.index + 1
  rule_action    = "allow"
  cidr_block     = aws_subnet.secure[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "out_secure_to_private" {
  count          = length(aws_subnet.private.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = true
  rule_number    = count.index + 101
  rule_action    = "allow"
  cidr_block     = aws_subnet.private[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "out_secure_to_transit" {
  count          = length(aws_subnet.transit.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = true
  rule_number    = count.index + 201
  rule_action    = "allow"
  cidr_block     = aws_subnet.transit[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}

###########
# INGRESS
###########

resource aws_network_acl_rule "in_secure_to_secure" {
  count          = length(aws_subnet.secure.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = false
  rule_number    = count.index + 1
  rule_action    = "allow"
  cidr_block     = aws_subnet.secure[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "in_secure_to_private" {
  count          = length(aws_subnet.private.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = false
  rule_number    = count.index + 101
  rule_action    = "allow"
  cidr_block     = aws_subnet.private[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "in_secure_to_transit" {
  count          = length(aws_subnet.transit.*.id)
  network_acl_id = aws_network_acl.secure.id
  egress         = false
  rule_number    = count.index + 201
  rule_action    = "allow"
  cidr_block     = aws_subnet.transit[count.index].cidr_block
  protocol       = -1
  to_port        = 0
  from_port      = 1

  lifecycle {
    create_before_destroy = true
  }
}
