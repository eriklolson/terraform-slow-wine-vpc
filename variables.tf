variable "region" {
  description = "The AWS region in which the resources will be created."
  type        = string
  default     = "us-west-2"
}
variable "availability_zone" {
  description = "The availability zone where the resources will reside."
  type        = string
  default     = "us-west-2a"
}
variable "ami" {
  description = "The ID of the Amazon Machine Image (AMI) used to create the EC2 instance."
  type        = string
  default     = "ami-0cf2b4e024cdb6960"
}
variable "instance_type" {
  description = "The type of EC2 instance used to create the instance."
  type        = string
  default     = "t4g.medium"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "server_port" {
  description = "Server use this port for http requests"
  type = number
  default = 80
}

variable "ssh_port" {
  description = "Describes the ssh port"
  type = number
  default = 22
}