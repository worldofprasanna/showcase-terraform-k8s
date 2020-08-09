
resource "aws_iam_role" "nd-app2-node" {
  name = "${var.environment}-eks-nd-app2-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "nd-app2-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nd-app2-node.name
}

resource "aws_iam_role_policy_attachment" "nd-app2-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nd-app2-node.name
}

resource "aws_iam_role_policy_attachment" "nd-app2-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nd-app2-node.name
}

resource "aws_eks_node_group" "nd-app2" {
  cluster_name    = aws_eks_cluster.nd-app2.name
  node_group_name = "${var.environment}_nd-app2_nodes"
  node_role_arn   = aws_iam_role.nd-app2-node.arn
  subnet_ids      = ["${var.public_subnet1_id}", "${var.public_subnet2_id}"]
  instance_types  = ["${var.eks_worker_instance_type}"]

  scaling_config {
    desired_size = "${var.eks_worker_desired_nodes}"
    max_size     = "${var.eks_worker_max_nodes}"
    min_size     = "${var.eks_worker_min_nodes}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nd-app2-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nd-app2-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nd-app2-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}