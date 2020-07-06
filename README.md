## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| max\_az | Max number of AZs | `number` | `3` | no |
| multi\_nat | Number of NAT Instances, 'true' will yield one per AZ while 'false' creates one NAT | `bool` | `false` | no |
| name | Name prefix for the resources of this stack | `string` | `""` | no |
| newbits | Number of bits to add to the vpc cidr when building subnets | `number` | `5` | no |
| private\_netnum\_offset | Start with this subnet for public ones, plus number of AZs | `number` | `5` | no |
| public\_nacl\_inbound\_tcp\_ports | TCP Ports to allow inbound on public subnet via NACLs (this list cannot be empty) | `list(string)` | <pre>[<br>  "80",<br>  "443",<br>  "22",<br>  "1194"<br>]</pre> | no |
| public\_nacl\_inbound\_udp\_ports | UDP Ports to allow inbound on public subnet via NACLs (this list cannot be empty) | `list(string)` | `[]` | no |
| public\_netnum\_offset | Start with this subnet for public ones, plus number of AZs | `number` | `0` | no |
| secure\_netnum\_offset | Start with this subnet for secure ones, plus number of AZs | `number` | `10` | no |
| tags | Extra tags to attach to resources | `map(string)` | `{}` | no |
| transit\_nacl\_inbound\_tcp\_ports | TCP Ports to allow inbound on transit subnet via NACLs (this list cannot be empty) | `list(string)` | <pre>[<br>  "1194"<br>]</pre> | no |
| transit\_nacl\_inbound\_udp\_ports | UDP Ports to allow inbound on transit subnet via NACLs (this list cannot be empty) | `list(string)` | <pre>[<br>  "1194"<br>]</pre> | no |
| transit\_netnum\_offset | Start with this subnet for secure ones, plus number of AZs | `number` | `15` | no |
| transit\_subnet | Create a transit subnet for VPC peering (only central account) | `bool` | `false` | no |
| vpc\_cidr | Network CIDR for the VPC | `string` | `""` | no |
| vpc\_flow\_logs\_retention | Retention in days for VPC Flow Logs CloudWatch Log Group | `number` | `365` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_subnet\_group\_id | n/a |
| internet\_gateway\_id | ID of Internet Gateway created |
| nat\_gateway\_ids | List of NAT Gateway IDs |
| private\_subnet\_cidrs | List of private subnet CIDRs |
| private\_subnet\_ids | List of private subnet IDs |
| public\_subnet\_cidrs | List of public subnet CIDRs |
| public\_subnet\_ids | List of public subnet IDs |
| secure\_subnet\_cidrs | List of secure subnet CIDRs |
| secure\_subnet\_ids | List of secure subnet IDs |
| vpc\_cidr | CIDR for VPC created |
| vpc\_id | ID for VPC created |

