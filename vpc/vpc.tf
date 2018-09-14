#VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
    }
}

#Public Subnets
resource "aws_subnet" "main-public-1a" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/20"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

    tags {
        Name = "main-public-1a"
    }
}

resource "aws_subnet" "main-public-1b" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.16.0/20"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1b"

    tags {
        Name = "main-public-1b"
    }
}

resource "aws_subnet" "main-public-1c" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.32.0/20"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1c"

    tags {
        Name = "main-public-1c"
    }
}

#Private Subnets
resource "aws_subnet" "main-private-1a" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.48.0/20"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1a"

    tags {
        Name = "main-private-1a"
    }
}

resource "aws_subnet" "main-private-1b" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.64.0/20"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1b"

    tags {
        Name = "main-private-1b"
    }
}

resource "aws_subnet" "main-private-1c" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.80.0/20"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1c"

    tags {
        Name = "main-private-1c"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "main-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "main-public-1a" {
    subnet_id = "${aws_subnet.main-public-1a.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-1b" {
    subnet_id = "${aws_subnet.main-public-1b.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-1c" {
    subnet_id = "${aws_subnet.main-public-1c.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}