provider "kubernetes" {
  host = data.aws_eks_cluster.eks.endpoint
  token = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
}
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks"
  cluster_version = "1.17"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  tags = {
    Name = "eks-cluster"
  }
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}