output "aws_vpc_id" {
  type        = string
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

output "aws_instance_pub_id" {
  type        = list(string)
  description = "The ID of the public instance"
  value       = aws_instance.pub.*.id
}

output "aws_instance_pvt_id" {
  type        = list(string)
  description = "The ID of the private instance"
  value       = aws_instance.pvt.*.id
}