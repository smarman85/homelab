resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpcCIDR
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
      created_by = "terraform"
      use = var.vpcUse
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main_vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.publicSubnets
    map_public_ip_on_launch = true
    availability_zone = var.publicAZ
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.privateSubnets
    map_public_ip_on_launch = false
    availability_zone = var.privateAZ
}
// resource "aws_subnet" "vpc_subnets" {
//     for_each = var.subnets
//     vpc_id = aws_vpc.main_vpc.id
//     cidr_block = each.value["cidr"]
//     map_public_ip_on_launch = each.value["public"]
//     availability_zone = each.value["az"]
// 
//     tags = {
//       name = "${var.vpcUse}-subnet"
//       created_by = "terraform"
//       public = each.value["public"]
//     }
// }