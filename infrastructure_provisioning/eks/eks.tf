resource "aws_iam_role" "cats-cluster" {
  name = "cats-cluster-role"

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

resource "aws_eks_cluster" "cats" {
  name     = var.cluster-name
  role_arn = aws_iam_role.cats-cluster.arn

  vpc_config {
    security_group_ids = ["${var.security_group_id}"]
    subnet_ids         = ["${var.public_subnet1_id}", "${var.public_subnet2_id}"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cats-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cats-cluster-AmazonEKSServicePolicy,
  ]
}