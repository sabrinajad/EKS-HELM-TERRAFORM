resource "aws_iam_role" "eksAssumeRole" {
  name = "eks-cluster-eks"

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

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksAssumeRole.name
}

resource "aws_eks_cluster" "eksHelm" {
  name     = "eksHelm"
  role_arn = aws_iam_role.eksAssumeRole.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.prv1.id,
      aws_subnet.prv2.id,
      aws_subnet.pub1.id,
      aws_subnet.pub2.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy]
}