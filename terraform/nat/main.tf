resource "aws_nat_gateway" "nat" {
  allocation_id = var.eip
  subnet_id     = var.pub_subnet
}

