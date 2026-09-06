variable "project_name" { type = string }
variable "vpc_cidr" { type = string }
variable "az_count" { type = number }

data "aws_availability_zones" "available" { state = "available" }

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "this" { vpc_id = aws_vpc.this.id }

resource "aws_subnet" "public" {
  count = var.az_count
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.project_name}-public-${count.index + 1}", "kubernetes.io/role/elb" = "1" }
}

resource "aws_subnet" "private" {
  count = var.az_count
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index + var.az_count)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "${var.project_name}-private-${count.index + 1}", "kubernetes.io/role/internal-elb" = "1" }
}

resource "aws_route_table" "public" { vpc_id = aws_vpc.this.id; route { cidr_block = "0.0.0.0/0"; gateway_id = aws_internet_gateway.this.id } }
resource "aws_route_table_association" "public" { count = var.az_count; subnet_id = aws_subnet.public[count.index].id; route_table_id = aws_route_table.public.id }

resource "aws_eip" "nat" { count = var.az_count; domain = "vpc" }
resource "aws_nat_gateway" "this" { count = var.az_count; allocation_id = aws_eip.nat[count.index].id; subnet_id = aws_subnet.public[count.index].id }
resource "aws_route_table" "private" { count = var.az_count; vpc_id = aws_vpc.this.id; route { cidr_block = "0.0.0.0/0"; nat_gateway_id = aws_nat_gateway.this[count.index].id } }
resource "aws_route_table_association" "private" { count = var.az_count; subnet_id = aws_subnet.private[count.index].id; route_table_id = aws_route_table.private[count.index].id }

output "vpc_id" { value = aws_vpc.this.id }
output "private_subnet_ids" { value = aws_subnet.private[*].id }
