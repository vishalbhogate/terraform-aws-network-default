variable "vpc_cidr" {
  default     = "" #example CIDR
  description = "Network CIDR for the VPC"
}

variable "name" {
  default     = ""
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

variable "public_nacl_inbound_tcp_ports" {
  type        = list(string)
  default     = ["80", "443", "22", "1194"]
  description = "TCP Ports to allow inbound on public subnet via NACLs (this list cannot be empty)"
}

variable "public_nacl_inbound_udp_ports" {
  type        = list(string)
  default     = []
  description = "UDP Ports to allow inbound on public subnet via NACLs (this list cannot be empty)"
}

variable "transit_nacl_inbound_tcp_ports" {
  type        = list(string)
  default     = ["1194"]
  description = "TCP Ports to allow inbound on transit subnet via NACLs (this list cannot be empty)"
}

variable "transit_nacl_inbound_udp_ports" {
  type        = list(string)
  default     = ["1194"]
  description = "UDP Ports to allow inbound on transit subnet via NACLs (this list cannot be empty)"
}

variable "vpc_flow_logs_retention" {
  default     = 365
  description = "Retention in days for VPC Flow Logs CloudWatch Log Group"
}