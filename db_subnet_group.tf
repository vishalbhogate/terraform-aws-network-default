resource aws_db_subnet_group "secure" {
  name       = "${lower(var.name)}-dbsubnetgroup"
  subnet_ids = aws_subnet.secure.*.id

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-DBSubnet"
      "Scheme"  = "secure"
      "EnvName" = var.name
    }
  )
}
