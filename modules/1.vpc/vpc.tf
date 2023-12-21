# vpc creation
resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-myvpc"
  }
}

#Public subnets creation in two AZ
resource "aws_subnet" "public_subnet_1_cidr" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.subnets[0]
  availability_zone = local.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public_subnet_1"
  }
}
resource "aws_subnet" "public_subnet_2_cidr" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.subnets[1]
  availability_zone = local.az2
  tags = {
    Name = "${var.env}-public_subnet_2"
  }
}

#Private subnets creation in two AZ
resource "aws_subnet" "private_subnet_1_cidr" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.subnets[2]
  availability_zone = local.az1 # automate if have time
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-private_subnet_1"
  }
}
resource "aws_subnet" "private_subnet_2_cidr" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.subnets[3]
  availability_zone = local.az2 # automate if have time
  tags = {
    Name = "${var.env}-private_subnet_2"
  }
}

# Create Public Route table 
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.env}-public_rt"
  }
}
# Create Private Route table 
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.env}-private_rt"
  }
}

# Associate the public subnets with public Route tables 
resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1_cidr.id
}
resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2_cidr.id
}
# Associate the public subnets with public Route tables 
resource "aws_route_table_association" "private_subnet_1_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1_cidr.id
}
resource "aws_route_table_association" "private_subnet_2_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_2_cidr.id
}


# create IG for public subnets
resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_route" "Igw_routing" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.Igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Elastic IP creation for NAT gateway

resource "aws_eip" "elastic_ip_for_nat_gateway" {
  domain                    = "vpc"
  #associate_with_private_ip = "10.0.0.5" # automate when you have time
  tags = {
    Name = "${var.env}-eip"
  }
}
# NAT gateway creation and add one public subnet atleast or add two for HA
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip_for_nat_gateway.id
  subnet_id     = aws_subnet.public_subnet_1_cidr.id
  tags = {
    Name = "${var.env}-nat-gw"
  }
  depends_on = [aws_eip.elastic_ip_for_nat_gateway]
}

# Adding NAT gw to Private Route table : private rt should be attached to NAT gw, but public subnet should be associated with NAT gw
resource "aws_route" "nat_gw_routing" {
  route_table_id = aws_route_table.private_route_table.id
  nat_gateway_id = aws_nat_gateway.nat_gw.id
  destination_cidr_block = "0.0.0.0/0"  # allow out traffic from instance to internet or IG
}