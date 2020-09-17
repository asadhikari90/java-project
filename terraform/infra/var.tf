########## env name##############
variable "env" {
  description = "env to deploy into, should typically ab_dev/ab_qa/ab_prod"
  default     = "dev"
}

###### Variable for Region ##########
variable "infra_region" {
  description = "region for the infra"
  default     = "us-west-2"
}

variable "key_credentials_path" {
  description = "key credentials path"
  default     = ""
}

###################### VPC vars #####################
# VPC CIDR block
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# VPC Tenancy
variable "instanceTenancy" {
  default = "default"
}

# VPC dns support value
variable "dnsSupport" {
  default = true
}

# VPC dns host name value
variable "dnsHostNames" {
  default = true
}

###########Tag for VPC
variable "vpc_tag_name" {
  description = "Tag for VPC Name fields"
  default     = "vpc"
}

###########variables public subnet########
#### CIDR Block
variable "cidr_pub_subnet_az_a" {
  description = "The CIDR block for the subnet."
  default     = "10.0.15.0/24"
}

#### Tag Name 
variable "pub_subnet_name_az_a" {
  description = "name of public subnets"
  default     = "pub_subnet_az_a"
}

###########variables private subnet########
#### CIDR Block
variable "cidr_pub_subnet_az_b" {
  description = "The CIDR block for the subnet."
  default     = "10.0.16.0/24"
}

#### Tag Name 
variable "pub_subnet_name_az_b" {
  description = "name of public subnets"
  default     = "private_subnet_az_b"
}

####### Two Availability zone for all subnets#########3
variable "availability_zone_a" {
  description = "The AZ for the subnet"
  default     = "us-west-2a"
}

variable "availability_zone_b" {
  description = "The AZ for the subnet"
  default     = "us-west-2b"
}

#### IGW Tag Name 
variable "one_igw" {
  default     = "igw"
}

#####PUBLIC ROUTE TABLE#######
variable "route_cidr" {
  default = "0.0.0.0/0"
}

variable "route_tag_name" {
 default = "public-Route-table"
}

#####PRIVATE ROUTE TABLE#######
variable "route_cidr_pri" {
  default = "0.0.0.0/0"
}

variable "pri_route_tag_name" {
 default = "private-Route-table"
}

########Jenkins SG#######
variable "security_groupname_jen_tom" {
  default = "security_group_jen_tom"
}

variable "from_ports_jen_tom" {
  default = "8080,22"
}

variable "to_ports_jen_tom" {
  default = "8080,22"
}

variable "cidrblocks_jen_tom" {
  default = ["0.0.0.0/0"]
}

variable "tag_name_value_jen_tom" {
  default = "Jen_tom_sg"
}


########nginx SG#######
variable "security_groupname_nginx" {
  default = "security_group_nginx"
}

variable "from_ports_nginx" {
  default = "80,22"
}

variable "to_ports_nginx" {
  default = "80,22"
}

variable "cidrblocks_nginx" {
  default = ["0.0.0.0/0"]
}

variable "tag_name_value_nginx" {
  default = "nginx_sg"
}

########Bastion SG#######
variable "security_groupname_bas" {
  default = "security_group_bastion"
}

variable "from_ports_bas" {
  default = "22"
}

variable "to_ports_bas" {
  default = "22"
}

variable "cidrblocks_bas" {
  default = ["0.0.0.0/0"]
}

variable "tag_name_value_bas" {
  default = "bastion_sg"
}

########mysql SG#######
variable "security_groupname_mysql" {
  default = "security_group_mysql"
}

variable "from_ports_mysql" {
  default = "3306,22"
}

variable "to_ports_mysql" {
  default = "3306,22"
}

variable "cidrblocks_mysql" {
  default = ["0.0.0.0/0"]
}

variable "tag_name_value_mysql" {
  default = "bastion_sg"
}

 ##############KEY PAIR ########

 variable "namekey" {
   default = "deployer_key"
 }

 variable "keypublic" {
   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBwi7Yo0oh8CRf5C81CPeKZEpvjZ/l73/xMxxntzQO/C1wnGK2BBx0dvYhqyQddyoOhzryWeXGFR94wJwqnOKX/gkQ3tgBeMfDYHgdsk+CKP5woFXsEYpdybJbZwdBAX6yOUf6iMP0mScIIgmDlYluAdcfN1vMv4UDz8N4WAekT2/X/5JRLesZl0MEaVx3b5t1KXjVI07A0k9jOUmY+p1CAsque1mjEZQ3W9J9tOSQweILcxuTlvP6QH1zrWLB1nNKbfqPh74bOvoIU4cUojsHs9G8U/dKcgAhBwvTqDsSdP0U+LqL+KtVl67LkAu2N9yOMHMHZxn70VB1UFCTc147"
 }

###############NGINX EC2#############
variable "ec2_ami" {
  default = "ami-003634241a8fcdec0"
}

variable "type_ec2" {
  default = "t2.micro"
}

variable "tag_ec2" {
  default = "NGINX"
}

###############Jenkins EC2#############
variable "jen_ec2_ami" {
  default = "ami-003634241a8fcdec0"
}

variable "jen_type_ec2" {
  default = "t2.medium"
}

variable "jen_tag_ec2" {
  default = "JENKINS"
}
###############Bastion EC2#############
variable "bas_ec2_ami" {
  default = "ami-003634241a8fcdec0"
}

variable "bas_type_ec2" {
  default = "t2.micro"
}

variable "bas_tag_ec2" {
  default = "BASTION"
}

###############Tomcat EC2#############
variable "tom_ec2_ami" {
  default = "ami-003634241a8fcdec0"
}

variable "tom_type_ec2" {
  default = "t2.micro"
}

variable "tom_tag_ec2" {
  default = "TOMCAT"
}

###############Mysql EC2#############
variable "mysql_ec2_ami" {
  default = "ami-003634241a8fcdec0"
}

variable "mysql_type_ec2" {
  default = "t2.micro"
}

variable "mysql_tag_ec2" {
  default = "MYSQL"
}

