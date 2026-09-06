variable "project_name" { type = string }
variable "cluster_name" { type = string }
variable "kubernetes_version" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

data "aws_iam_policy_document" "cluster_assume" { statement { actions = ["sts:AssumeRole"]; principals { type = "Service"; identifiers = ["eks.amazonaws.com"] } } }
resource "aws_iam_role" "cluster" { name = "${var.cluster_name}-cluster-role"; assume_role_policy = data.aws_iam_policy_document.cluster_assume.json }
resource "aws_iam_role_policy_attachment" "cluster" { role = aws_iam_role.cluster.name; policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" }

resource "aws_eks_cluster" "this" {
  name = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version = var.kubernetes_version
  vpc_config { subnet_ids = var.private_subnet_ids; endpoint_private_access = true; endpoint_public_access = true }
  depends_on = [aws_iam_role_policy_attachment.cluster]
}

resource "aws_iam_role" "nodes" {
  name = "${var.cluster_name}-node-role"
  assume_role_policy = jsonencode({ Version = "2012-10-17", Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }] })
}
resource "aws_iam_role_policy_attachment" "worker" { role = aws_iam_role.nodes.name; policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" }
resource "aws_iam_role_policy_attachment" "ecr" { role = aws_iam_role.nodes.name; policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" }
resource "aws_iam_role_policy_attachment" "cni" { role = aws_iam_role.nodes.name; policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" }

resource "aws_eks_node_group" "system" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "system"
  node_role_arn = aws_iam_role.nodes.arn
  subnet_ids = var.private_subnet_ids
  instance_types = ["t3.medium"]
  scaling_config { desired_size = 2; min_size = 2; max_size = 5 }
  update_config { max_unavailable = 1 }
  depends_on = [aws_iam_role_policy_attachment.worker, aws_iam_role_policy_attachment.ecr, aws_iam_role_policy_attachment.cni]
}

output "cluster_name" { value = aws_eks_cluster.this.name }
output "cluster_endpoint" { value = aws_eks_cluster.this.endpoint }
