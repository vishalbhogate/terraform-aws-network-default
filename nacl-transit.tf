resource aws_network_acl "transit" {
  count      = var.transit_subnet ? 1 : 0
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.transit.*.id

  tags = merge(
    var.tags,
    map(
      "Name", "${var.name}-ACL-Transit",
      "Scheme", "transit",
      "EnvName", var.name
    )
  )

  lifecycle {
    create_before_destroy = true
  }
}

###########
# EGRESS
###########

resource "aws_network_acl_rule" "out_transit_world" {
  count          = var.transit_subnet ? 1 : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = 1
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

###########
# INGRESS
###########

resource "aws_network_acl_rule" "in_transit_local" {
  count          = var.transit_subnet ? 1 : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = 1
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = aws_vpc.default.cidr_block
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl_rule" "in_transit_tcp" {
  count          = var.transit_subnet ? length(var.transit_nacl_inbound_tcp_ports) : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = count.index + 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = var.transit_nacl_inbound_tcp_ports[count.index]
  to_port        = var.transit_nacl_inbound_tcp_ports[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl_rule" "in_transit_tcp_return" {
  count          = var.transit_subnet ? 1 : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = 201
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = "1024"
  to_port        = "65535"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl_rule" "in_transit_udp" {
  count          = var.transit_subnet ? length(var.transit_nacl_inbound_udp_ports) : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = count.index + 301
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = var.transit_nacl_inbound_udp_ports[count.index]
  to_port        = var.transit_nacl_inbound_udp_ports[count.index]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl_rule" "in_transit_udp_return" {
  count          = var.transit_subnet ? 1 : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = 401
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = "1024"
  to_port        = "65535"
}

resource "aws_network_acl_rule" "in_transit_icmp_reply" {
  count          = var.transit_subnet ? 1 : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = 501
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_code      = -1
  icmp_type      = 0

  lifecycle {
    create_before_destroy = true
  }
}

# redundant as we are already allowing the VPC CIDR

resource "aws_network_acl_rule" "in_transit_from_private" {
  count          = var.transit_subnet ? length(aws_subnet.private.*.id) : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = count.index + 601
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_subnet.private[count.index].cidr_block
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_acl_rule" "in_transit_from_secure" {
  count          = var.transit_subnet ? length(aws_subnet.secure.*.id) : 0
  network_acl_id = aws_network_acl.transit[0].id
  rule_number    = count.index + 701
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_subnet.secure[count.index].cidr_block
  from_port      = 0
  to_port        = 0

  lifecycle {
    create_before_destroy = true
  }
}