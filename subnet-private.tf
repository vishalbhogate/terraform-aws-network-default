resource aws_subnet "private" {
  count  = length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.default.id
  cidr_block = cidrsubnet(
    aws_vpc.default.cidr_block,
    var.newbits,
    count.index + var.private_netnum_offset
  )
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-Subnet-Private-${upper(data.aws_availability_zone.az[count.index].name_suffix)}"
      "Scheme"  = "private"
      "EnvName" = var.name
    }
  )
}

resource aws_route_table "private" {
  count  = var.multi_nat ? length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names) : 1
  vpc_id = aws_vpc.default.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-rtb-private-${count.index}"
      "Scheme"  = "private"
      "EnvName" = var.name
    }
  )

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_nat_gateway.nat_gw]
}

resource aws_route "nat_route" {
  count                  = var.multi_nat ? length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names) : 1
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_nat_gateway.nat_gw]
}

// we are using this logic to share the One NAT instance across the differnt AZ. Below logic it will create the 
/* resource "aws_route" "nat_route_single_nat" {
  count                  = var.multi_nat ? 0 : length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[0].id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_nat_gateway.nat_gw]
} */

resource aws_route_table_association "private" {
  count          = var.multi_nat ? length(data.aws_availability_zones.available.names) > var.max_az ? var.max_az : length(data.aws_availability_zones.available.names) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id

  lifecycle {
    create_before_destroy = true
  }
}


