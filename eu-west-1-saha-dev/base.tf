module "base" {
  source = "git@github.com:Alizandieh/tf-modules.git//modules/base?ref=8d305dd"

  cidr     = "10.62.0.0/16"
  platform = "saha-dev"

  # number of AZs you'd like to have
  az_count = 2

  # It defines how much smaller the subnets will be compared to the original CIDR block.
  # for example /16 + 8 = /24
  newbits = 8

  # As an example this would give:
  # Private Subnets: [10.62.0.0/24,10.62.1.0/24]
  # Public Subnets: [10.62.2.0/24,10.62.3.0/24]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpc_endpoints = true

  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false

}

# Adding a new route table rule for the VPC peering to Bridge V2
resource "aws_route" "peering" {
  for_each                  = toset(module.base.private_route_table_ids)
  route_table_id            = each.value
  destination_cidr_block    = "10.10.0.0/16"
  vpc_peering_connection_id = "pcx-0b6746f53607a0ed5"
}

# Adding a new route table rule for the VPC peering to Brigge US
resource "aws_route" "peering_us" {
  for_each                  = toset(module.base.private_route_table_ids)
  route_table_id            = each.value
  destination_cidr_block    = "10.63.0.0/18"
  vpc_peering_connection_id = "pcx-025545cbdc4e1b62f"
}
