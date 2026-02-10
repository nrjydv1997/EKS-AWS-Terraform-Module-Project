#-------SG forbastion host----------
resource "aws_security_group" "bastion-sg" {
  name = "bastion-sg-${terraform.workspace}"
  description = "Allow SSH to bastion"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name =  "bastion-sg-${terraform.workspace}"
  }
}


#-------SG for eks cluster----------

resource "aws_security_group" "eks-cluster-sg" {
  name = "eks-cluster-sg-${terraform.workspace}"
  description = "Allow 443 from Jump server only"

  vpc_id = var.vpc_id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg-${terraform.workspace}"
  }
}

