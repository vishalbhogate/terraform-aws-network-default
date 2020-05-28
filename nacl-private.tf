resource aws_network_acl "private" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.private.*.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-Private-ACL"
      "Scheme"  = "Private"
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

#Instance in the private subnet sends a packet to the internet, it leaves with the internet address in the header's destination

resource aws_network_acl_rule "out_private_to_world" {
  network_acl_id = aws_network_acl.private.id
  egress         = true
  rule_number    = "1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  protocol       = -1
  to_port        = 0
  from_port      = 0

  lifecycle {
    create_before_destroy = true
  }
}

###########
# INGRESS
###########

#Instance in the private subnet sends a packet to the internet, it leaves with the internet address in the header's destination
resource aws_network_acl_rule "in_private_from_world_tcp" {
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = "1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  protocol       = "tcp"
  to_port        = 0
  from_port      = 0

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "in_private_from_world_icmp_reply" {
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = "100"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  protocol       = "icmp"
  icmp_code      = -1
  icmp_type      = 0

  lifecycle {
    create_before_destroy = true
  }
}

############### Whitelist either subnets or whole cidr################

resource aws_network_acl_rule "in_private_from_private_subnet" {
  count          = length(aws_subnet.private.*.id)
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = count.index + 201
  rule_action    = "allow"
  cidr_block     = aws_subnet.private[count.index].cidr_block
  protocol       = -1
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "in_private_from_public_subnet" {
  count          = length(aws_subnet.public.*.id)
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = count.index + 301
  rule_action    = "allow"
  cidr_block     = aws_subnet.public[count.index].cidr_block
  protocol       = -1
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_network_acl_rule "in_private_from_secure_subnet" {
  count          = length(aws_subnet.secure.*.id)
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = count.index + 401
  rule_action    = "allow"
  cidr_block     = aws_subnet.secure[count.index].cidr_block
  protocol       = -1
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

################# OR ######################

/* resource aws_network_acl_rule "in_private_from_local" {
  network_acl_id = aws_network_acl.private.id
  egress         = false
  rule_number    = 501
  rule_action    = "allow"
  cidr_block     = aws_vpc.default.cidr_block
  protocol       = -1
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
} */