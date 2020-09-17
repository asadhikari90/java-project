variable "cidr_block" {
  description = "The CIDR block for the VPC"
  #default     = "10.0.0.0/16"
}

# VPC Tenancy
variable "instance_tenancy" {
  default = "default"
}

# VPc dns support value
variable "enable_dns_support" {
  default = false
}

# VPC dns host name value
variable "enable_dns_hostnames" {
  default = true
}


variable "vpc_Name_tag" {
  description = "The Value of the Name tag"
  #default     = "terra_1_assignment"
}


