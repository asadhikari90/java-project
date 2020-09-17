resource "aws_route_table_association" "route_subnet" {
 subnet_id = var.subnetid
 route_table_id = var.routetable_id
}

