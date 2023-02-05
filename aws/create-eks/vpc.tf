# VPC
resource "aws_vpc" "eksvpc" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${random_pet.name.id}-vpc",
    "kubernetes.io/cluster/${random_pet.name.id}" = "shared"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = var.availability_zones_count 

  vpc_id            = aws_vpc.eksvpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${random_pet.name.id}-public-sg"
    "kubernetes.io/cluster/${random_pet.name.id}" = "shared"
    "kubernetes.io/role/elb"                       = 1
  }

  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.eksvpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index + var.availability_zones_count)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${random_pet.name.id}-private-sg"
    "kubernetes.io/cluster/${random_pet.name.id}" = "shared"
    "kubernetes.io/role/internal-elb"              = 1
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.eksvpc.id

  tags = {
    "Name" = "${random_pet.name.id}-igw"
  }

  depends_on = [aws_vpc.eksvpc]
}

# Route Table(s)
# Route the public subnet traffic through the IGW
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.eksvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${random_pet.name.id}-Default-rt"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "internet_access" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.main.id
}

# NAT Elastic IP
resource "aws_eip" "main" {
  vpc = true

  tags = {
    Name = "${random_pet.name.id}-ngw-ip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${random_pet.name.id}-ngw"
  }
 depends_on = [aws_internet_gateway.this, aws_eip.main, aws_subnet.public]

}

# Add route to route table
resource "aws_route" "main" {
  route_table_id         = aws_vpc.eksvpc.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

