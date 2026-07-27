terraform{
    required_providers{
        aws ={
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws"{
    region = "us-east-1"
}

resource "aws_vpc" "my_vpc"{
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet"{
    for_each = var.public_subnet_cidr
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = each.value
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my_igw"{
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table"{
    vpc_id = aws_vpc.my_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id

    }
}

resource "aws_route_table_association" "public_subnet_association"{
    for_each = var.public_subnet_cidr
    subnet_id = aws_subnet.public_subnet[each.key].id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "my_sg"{
    name = "my_public_security_group"
    vpc_id = aws_vpc.my_vpc.id
    dynamic "ingress"{
        for_each = var.ingress_ports
        content{
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
