variable "vpc_cidr" {
  default     = "10.0.0.0/16" #example CIDR
  description = "Network CIDR for the VPC"
}

variable "name" {
  default     = "labs"
  description = "Name prefix for the resources of this stack"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "newbits" {
  default     = 5
  description = "Number of bits to add to the vpc cidr when building subnets"
}

variable "max_az" {
  default     = 3
  description = "Max number of AZs"
}

variable "public_netnum_offset" {
  default     = 0
  description = "Start with this subnet for public ones, plus number of AZs"
}

variable "private_netnum_offset" {
  default     = 5
  description = "Start with this subnet for public ones, plus number of AZs"
}

variable "multi_nat" {
  default     = false
  description = "Number of NAT Instances, 'true' will yield one per AZ while 'false' creates one NAT"

}

variable "secure_netnum_offset" {
  default     = 10
  description = "Start with this subnet for secure ones, plus number of AZs"
}

variable "transit_netnum_offset" {
  default     = 15
  description = "Start with this subnet for secure ones, plus number of AZs"
}

variable "transit_subnet" {
  default     = false
  description = "Create a transit subnet for VPC peering (only central account)"
}
