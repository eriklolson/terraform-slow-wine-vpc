# Create a vpc 
resource "aws_vpc" "mamba_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "Mamba VPC"
  }
}
# Create an internet Gateway
resource "aws_internet_gateway" "mamba_GW" {
  vpc_id = aws_vpc.mamba_vpc.id

  tags = {
    name = "Mamba VPC Gateway"
  }
}
# Create a custom route table
# resource "aws_route_table" "mamba_RT" {cd /
#   vpc_id = aws_vpc.mamba_vpc.id
#   tags = {
#     name = "mamba-route-table"
#   }
# }
# # create route
# resource "aws_route" "mamba_route" {
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id  = aws_internet_gateway.mamba_GW.id
#   route_table_id = aws_route_table.mamba_RT.id
# }

# SUBNETS
# Public subnet
resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.mamba_vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
# Private subnet
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.mamba_vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

associate internet gateway to the route table by using subnet
resource "aws_route_table_association" "mamba_assoc" {
  subnet_id = aws_subnet.mamba_SN.id
  route_table_id = aws_route_table.mamba_RT.id
}
# # create security group to allow ingoing ports
# resource "aws_security_group" "mamba_SG" {
#   name        = "sec_group"
#   description = "security group for the EC2 instance"
#   vpc_id      = aws_vpc.mamba_vpc.id
#   ingress = [
#     {
#       description      = "https traffic"
#       from_port        = 443
#       to_port          = 443
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0", aws_vpc.mamba_vpc.cidr_block]
#       ipv6_cidr_blocks  = []
#       prefix_list_ids   = []
#       security_groups   = []
#       self              = false
#     },
#     {
#       description      = "http traffic"
#       from_port        = 80
#       to_port          = 80
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0", aws_vpc.mamba_vpc.cidr_block]
#       ipv6_cidr_blocks  = []
#       prefix_list_ids   = []
#       security_groups   = []
#       self              = false
#     },
#     {
#       description      = "ssh"
#       from_port        = 22
#       to_port          = 22
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0", aws_vpc.mamba_vpc.cidr_block]
#       ipv6_cidr_blocks  = []
#       prefix_list_ids   = []
#       security_groups   = []
#       self              = false
#     }
#   ]
#   egress = [
#     {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       description      = "Outbound traffic rule"
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       security_groups  = []
#       self             = false
#     }
#   ]
#   tags = {
#     name = "allow_web"
#   }
# }

# create a network interface with private ip from step 4
resource "aws_network_interface" "mamba_net_interface" {
  subnet_id = aws_subnet.mamba_SN.id
  security_groups = [aws_security_group.mamba_SG.id]
}
# assign a elastic ip to the network interface created in step 7
resource "aws_eip" "mamba_eip" {
  vpc = true
  network_interface = aws_network_interface.mamba_net_interface.id
  associate_with_private_ip = aws_network_interface.mamba_net_interface.private_ip
  depends_on = [aws_internet_gateway.mamba_GW, aws_instance.mamba_ec2]
}
# create an ubuntu server and install/enable apache2
resource "aws_instance" "mamba_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  key_name = "ec2_key"
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.mamba_net_interface.id
  }
  
  user_data = file("${path.module}/user_data.sh")
  
  tags = {
    name = "web_server"
  }
}