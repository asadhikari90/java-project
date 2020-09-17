################# Region of Infra #################
provider "aws" {
  version                 = "~> 2.0"
  shared_credentials_file = var.key_credentials_path
  region                  = var.infra_region
}

######## Creating VPC ####################
module "vpc" {
  source               = "../vpc"
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  vpc_Name_tag         = "${var.env}_${var.vpc_tag_name}"
}

#########Creating  Public Subnet ##############
module "bastion_host_pub_subnet_az_a" {
  source            = "../subnets"
  vpc_id            = module.vpc.id
  cidr_subnet       = var.cidr_pub_subnet_az_a
  availability_zone = var.availability_zone_a
  subnet_name       = "${var.env}_${var.pub_subnet_name_az_a}"
}

############Creating Private Subnet############
module "bastion_host_pub_subnet_az_b" {
  source            = "../subnets"
  vpc_id            = module.vpc.id
  cidr_subnet       = var.cidr_pub_subnet_az_b
  availability_zone = var.availability_zone_b
  subnet_name       = "${var.env}_${var.pub_subnet_name_az_b}"
}

############INTERNET GATEWAY#########################
module "internet_gateway" {
 source   = "../igw"
 vpc_id   = module.vpc.id
 igw_name = "${var.env}_${var.one_igw}"

}

################ELASTIC IP###########################
module "el_ip"{
  source = "../elasticip"
}

#############NAT GATEWAY##############################

module "nat_gateway" {
 source = "../nat"
 eip = module.el_ip.id
 pub_subnet = module.bastion_host_pub_subnet_az_a.subnet_id

}

###############Public Route Table#####################

module "pub_route_table" {
 source = "../route"
 vpc_id = module.vpc.id
 cidr_route = var.route_cidr
 igw_route = module.internet_gateway.igw_id
 route_name = "${var.env}_${var.route_tag_name}"

}

###public Subnet Association

module "pub_subnet_association_to_routetable" {
  source = "../subnetAssociation"
  subnetid = module.bastion_host_pub_subnet_az_a.subnet_id
  routetable_id = module.pub_route_table.id

}

###############Private Route Table#####################

module "private_route_table" {
 source = "../route"
 vpc_id = module.vpc.id
 cidr_route = var.route_cidr_pri
 igw_route = module.nat_gateway.id
 route_name = "${var.env}_${var.pri_route_tag_name}"

}

###Subnet Association

module "pri_subnet_association_to_routetable" {
  source = "../subnetAssociation"
  subnetid = module.bastion_host_pub_subnet_az_b.subnet_id
  routetable_id = module.private_route_table.id

}

############Security Group jenkins and tomcat#############

module "jen_tom_sg" {
 source = "../securitygroup"
 security_group_name = var.security_groupname_jen_tom
 vpc_id = module.vpc.id
 from_ports = var.from_ports_jen_tom
 to_ports = var.to_ports_jen_tom
 cidrblocks = var.cidrblocks_jen_tom
 tag_name_value = var.tag_name_value_jen_tom
}

############Security Group Nginx#############

module "nginx_sg" {
 source = "../securitygroup"
 security_group_name = var.security_groupname_nginx
 vpc_id = module.vpc.id
 from_ports = var.from_ports_nginx
 to_ports = var.to_ports_nginx
 cidrblocks = var.cidrblocks_nginx
 tag_name_value = var.tag_name_value_nginx
}

############Security Group Bastion#############

module "bastion_sg" {
 source = "../securitygroup"
 security_group_name = var.security_groupname_bas
 vpc_id = module.vpc.id
 from_ports = var.from_ports_bas
 to_ports = var.to_ports_bas
 cidrblocks = var.cidrblocks_bas
 tag_name_value = var.tag_name_value_bas
}

############Security Group Mysql#############

module "mysql_sg" {
 source = "../securitygroup"
 security_group_name = var.security_groupname_mysql
 vpc_id = module.vpc.id
 from_ports = var.from_ports_mysql
 to_ports = var.to_ports_mysql
 cidrblocks = var.cidrblocks_mysql
 tag_name_value = var.tag_name_value_mysql
}

#############KEY PAIR################

module "key_pair" {
  source = "../keypair"
  keyname = var.namekey
  publickey =  var.keypublic
}

################ Nginx EC2######################
module "nginx_ec2" {
  source = "../ec2"
  ami_ec2 = var.ec2_ami
  ec2_type = var.type_ec2
  subnetid = module.bastion_host_pub_subnet_az_a.subnet_id
  ec2_sg = [module.nginx_sg.id]
  publicip = "true"
  keypair-name = module.key_pair.id
  ec2_tag = var.tag_ec2
}


##################Jenkins EC2########################
module "jenkins_ec2" {
 source = "../ec2"
  ami_ec2 = var.jen_ec2_ami
  ec2_type = var.jen_type_ec2
  subnetid = module.bastion_host_pub_subnet_az_a.subnet_id
  ec2_sg = [module.jen_tom_sg.id]
  publicip = "true"
  keypair-name = module.key_pair.id
  ec2_tag = var.jen_tag_ec2

}

##################Bastion EC2########################
module "bastion_ec2" {
 source = "../ec2"
  ami_ec2 = var.bas_ec2_ami
  ec2_type = var.bas_type_ec2
  subnetid = module.bastion_host_pub_subnet_az_a.subnet_id
  ec2_sg = [module.bastion_sg.id]
  publicip = "true"
  keypair-name = module.key_pair.id
  ec2_tag = var.bas_tag_ec2

}


##################Tomcat EC2########################
module "tomcat_ec2" {
 source = "../ec2"
  ami_ec2 = var.tom_ec2_ami
  ec2_type = var.tom_type_ec2
  subnetid = module.bastion_host_pub_subnet_az_b.subnet_id
  ec2_sg = [module.jen_tom_sg.id]
  publicip = "false"
  keypair-name = module.key_pair.id
  ec2_tag = var.tom_tag_ec2

}

##################Mysql EC2########################
module "mysql_ec2" {
 source = "../ec2"
  ami_ec2 = var.mysql_ec2_ami
  ec2_type = var.mysql_type_ec2
  subnetid = module.bastion_host_pub_subnet_az_b.subnet_id
  ec2_sg = [module.mysql_sg.id]
  publicip = "false"
  keypair-name = module.key_pair.id
  ec2_tag = var.mysql_tag_ec2

}

terraform {
  backend "s3" {
    bucket = "mcleanbucket"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
