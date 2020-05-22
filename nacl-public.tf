resource aws_network_acl "public" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.secure.*.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-Public-NACL"
      "EnvName" = var.name
      "Scheme"  = "secure"
    }
  )
}
