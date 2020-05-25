resource aws_security_group "public" {
  vpc_id      = aws_vpc.default.id
  description = "Public ALB"
  name        = "${var.name}-SecurityGroup-ALB"

  dynamic "ingress" {
    iterator = port
    for_each = var.public_nacl_inbound_tcp_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = aws_subnet.public.*.cidr_block
    }
  }

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-SecurityGroup-ALB"
      "Scheme"  = "Public"
      "EnvName" = var.name
    }
  )
}
