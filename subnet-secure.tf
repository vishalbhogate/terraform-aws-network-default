resource aws_subnet "secure" {
  count  = length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.default.id
  cidr_block = cidrsubnet(
    aws_vpc.default.cidr_block,
    var.newbits,
    count.index + var.secure_netnum_offset
  )
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-Subnet-Secure-${upper(data.aws_availability_zone.az[count.index].name_suffix)}"
      "Scheme"  = "Secure"
      "EnvName" = var.name
    }
  )
}

resource aws_route_table "secure" {
  vpc_id = aws_vpc.default.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-rtb-secure"
      "Scheme"  = "secure"
      "EnvName" = var.name
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_route_table_association "secure" {
  count          = length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.secure.id
  subnet_id      = aws_subnet.secure[count.index].id

  lifecycle {
    create_before_destroy = true
  }

}


