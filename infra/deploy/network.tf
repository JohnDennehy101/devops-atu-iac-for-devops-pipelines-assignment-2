resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "${local.prefix}-primary"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"

  tags = {
    Name = "${local.prefix}-public-a"
  }
}

resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "${local.prefix}-public-a"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

resource "aws_route" "public_internet_access_a" {
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}


resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}b"

  tags = {
    Name = "${local.prefix}-public-b"
  }
}

resource "aws_route_table" "public_b" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "${local.prefix}-public-b"
  }
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_b.id
}

resource "aws_route" "public_internet_access_b" {
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "${local.prefix}-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "${data.aws_region.current.name}b"
  tags = {
    Name = "${local.prefix}-private-b"
  }
}
