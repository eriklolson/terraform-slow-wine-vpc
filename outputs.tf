output "vpc_id" {
    description = "vpc id"
    value = aws_vpc.mamba_vpc.id
}
output "subnet_id" {
    description = "private ip(subnet)"
    value = aws_subnet.mamba_subnet.id
}
output "IGW_id" {
    description = "internet gateway id"
    value = aws_internet_gateway.mamba_GW.id
}
# output "routetable_id" {
#     description = "route table id"
#     value = aws_route_table.mamba_RT.id
# }
output "SG_id" {
    description = "security group id"
    value = aws_security_group.mamba_SG.id
}
output "eip" {
    description = "public Ip of eip"
    value = aws_eip.mamba_eip.public_ip
}
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.mamba_ec2.id
}
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.mamba_ec2.private_ip
}
