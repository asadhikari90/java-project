resource "aws_instance" "dev_ec2" {

 ami = var.ami_ec2
 instance_type = var.ec2_type

 subnet_id = var.subnetid

 vpc_security_group_ids = var.ec2_sg
 associate_public_ip_address = var.publicip
 key_name = var.keypair-name
 
tags = {
 Name = var.ec2_tag
}
}
