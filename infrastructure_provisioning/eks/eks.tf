resource "aws_iam_role" "nd-app2-cluster" {
  name = "${var.environment}-nd-app2-cluster-role"

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

resource "aws_iam_role_policy_attachment" "nd-app2-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.nd-app2-cluster.name
}

resource "aws_iam_role_policy_attachment" "nd-app2-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.nd-app2-cluster.name
}

resource "aws_eks_cluster" "nd-app2" {
  name     = "${var.environment}-${var.cluster-name}"
  role_arn = aws_iam_role.nd-app2-cluster.arn

  vpc_config {
    security_group_ids = ["${var.web_security_group_id}"]
    subnet_ids         = ["${var.public_subnet1_id}", "${var.public_subnet2_id}"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.nd-app2-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.nd-app2-cluster-AmazonEKSServicePolicy,
  ]
}