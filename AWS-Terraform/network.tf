#VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "${var.vpc_name}-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "pub_sub" {
  count                   = length(var.pub_subnet_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pub_subnet_cidr_block, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.vpc_name}-pub-subnet-${count.index}"
  }
}

# Private Subnet
resource "aws_subnet" "pvt_sub" {
  count                   = length(var.pvt_subnet_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pvt_subnet_cidr_block, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.vpc_name}-pvt-subnet-${count.index}"
  }
}

#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
}

#Route Table - Public
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.vpc_name}-pub-rt"
  }
}

#NAT Gateway
resource "aws_eip" "nat_eip" {
  tags = {
    "Name" = "${var.vpc_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  # Place in the first public subnet (index 0)
  subnet_id     = aws_subnet.pub_sub[0].id 
  
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

#Route Table - Private
resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id 
  }
    tags = {
    "Name" = "${var.vpc_name}-pvt-rt"
  }
}

resource "aws_route_table_association" "pub_sn_ass" {
  count          = length(var.pub_subnet_cidr_block)
  subnet_id      = element(aws_subnet.pub_sub.*.id, count.index)
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pvt_sn_ass" {
  count          = length(var.pvt_subnet_cidr_block)
  subnet_id      = element(aws_subnet.pvt_sub.*.id, count.index)
  route_table_id = aws_route_table.pvt_rt.id
}
resource "aws_security_group" "sg" {
  name        = "${var.vpc_name}-sg"
  description = "Security group for ${var.vpc_name}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}