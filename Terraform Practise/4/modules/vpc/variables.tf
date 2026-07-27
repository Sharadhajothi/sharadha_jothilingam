variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = map(string)
}

variable "ingress_ports"{
    description = "Ingress ports for dynamic block"
    type = list(number)
    default = [22,80,443]
}