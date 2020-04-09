resource "aws_iam_role" "cats-cluster" {
  name = "terraform-eks-cats-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cats-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cats-cluster.name
}

resource "aws_iam_role_policy_attachment" "cats-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cats-cluster.name
}

resource "aws_security_group" "cats-cluster" {
  name        = "terraform-eks-cats-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.cats.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-cats"
  }
}

resource "aws_eks_cluster" "cats" {
  name     = var.cluster-name
  role_arn = aws_iam_role.cats-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.cats-cluster.id]
    subnet_ids         = aws_subnet.cats[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.cats-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cats-cluster-AmazonEKSServicePolicy,
  ]
}