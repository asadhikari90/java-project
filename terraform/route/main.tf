resource "aws_route_table" "route" {
 vpc_id = var.vpc_id

 route {
  cidr_block = var.cidr_route
  gateway_id = var.igw_route
}

tags = {
 Name = var.route_name
}
}
