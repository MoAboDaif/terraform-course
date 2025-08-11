module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${terraform.workspace}-${var.cluster_name}"
  kubernetes_version = var.cluster_version

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = var.compute_config.enabled
    node_pools = var.compute_config.node_pools
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = var.eks_managed_node_groups.calculator_app.ami_type
      instance_types = var.eks_managed_node_groups.calculator_app.instance_types

      min_size     = var.eks_managed_node_groups.calculator_app.min_size
      max_size     = var.eks_managed_node_groups.calculator_app.max_size
      desired_size = var.eks_managed_node_groups.calculator_app.desired_size
    }
  }

  tags = merge(
    var.tags,
    {
      workspace = terraform.workspace
    }
  )
}