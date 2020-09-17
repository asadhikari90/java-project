variable "vpc_id" {
  default = ""
}

variable "cidr_subnet" {
  description = "The CIDR block for the subnet."
  default     = ""
}

variable "availability_zone" {
  description = "The AZ for the subnet"
  default     = ""
}

variable "subnet_name" {
}
