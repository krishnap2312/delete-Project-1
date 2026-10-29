variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "RED"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Range"
  type        = string
}

variable "region" {
  description = "The AWS region to create resources - default is us-east-1"
  default     = "us-east-1"
  type        = string
}

variable "pub_subnet_cidr_block" {
  description = "Public Subnet CIDR Range"
  type        = list(string)
}
variable "pvt_subnet_cidr_block" {
  description = "Private Subnet CIDR Range"
  type        = list(string)
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  default     = "t2.micro"
  type        = string
}

variable "pub_ec2_count" {
  description = "Number of Public EC2 instances to create"
  default     = 1
  type        = number
}

variable "pvt_ec2_count" {
  description = "Number of Private EC2 instances to create"
  default     = 1
  type        = number
}