# Public EC2 instance
resource "aws_instance" "pub" {
  count           = var.pub_ec2_count
  ami             = "ami-0d97d7f07b25dd693"
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.pub_sub.*.id, 0)
  security_groups = [aws_security_group.sg.id]
  tags = {
    "Name" = "${var.vpc_name}-pub-ec2-${count.index}"
  }
}

# Private EC2 instance
resource "aws_instance" "pvt" {
  count           = var.pvt_ec2_count
  ami             = "ami-0d97d7f07b25dd693"
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.pvt_sub.*.id, 0)
  security_groups = [aws_security_group.sg.id]
  tags = {
    "Name" = "${var.vpc_name}-pvt-ec2-${count.index}"
  }
}