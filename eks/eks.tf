module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # basic cluster identity
  name               = var.cluster_name
  kubernetes_version = var.cluster_version  # or set a literal like "1.28"

  # networking (use the vpc module outputs)
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets   # do NOT use concat(...) with one arg

  # enable IRSA / OIDC
  enable_irsa = true

  # map your var.node_groups -> module's eks_managed_node_groups
  eks_managed_node_groups = {
    for ng_name, ng in var.node_groups : ng_name => {
      instance_types = [ng.instance_type]
      desired_size   = ng.desired_size
      min_size       = ng.min_size
      max_size       = ng.max_size
      # optionally add other supported fields here (labels, disk_size, taints, ...)
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
