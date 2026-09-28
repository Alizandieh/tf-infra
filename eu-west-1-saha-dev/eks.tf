module "saha_eks" {
  source = "git@github.com:Alizandieh/tf-modules.git//modules/EKS?ref=8d305dd"

  platform                       = "saha-dev"
  cluster_version                = "1.36"
  cluster_endpoint_public_access = true
  create_cloudwatch_log_group    = false
  enabled_log_types              = []

  cluster_admin_role_arn = "arn:aws:iam::570282482054:role/prod-CrossAccountDevOps"

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    eks-pod-identity-agent = {}
    aws-ebs-csi-driver     = {}
  }

  vpc_id                  = module.base.vpc_id
  subnet_ids              = module.base.subnets["private"]
  ami_type                = "AL2023_x86_64_STANDARD"
  ami_id                  = "ami-06ecd8d70b87ba6d8"
  user_data_template_path = "user_data.tpl"
  node_root_volume_size   = 40
  node_security_group_additional_rules = {
    custom_ingress_cluster_kubelet = {
      description                   = "Cluster API to node kubelets"
      protocol                      = "tcp"
      from_port                     = 10200
      to_port                       = 10300
      type                          = "ingress"
      source_cluster_security_group = true
    },
    custom_ingress_cluster_kubelet_istio = {
      description                   = "Cluster API to node kubelets for Istio"
      protocol                      = "tcp"
      from_port                     = 15017
      to_port                       = 15017
      type                          = "ingress"
      source_cluster_security_group = true
    },
    custom_ingress_vxlan = {
      description = "Allow Calico VXLAN (UDP 4789) between nodes"
      protocol    = "udp"
      from_port   = 4789
      to_port     = 4789
      type        = "ingress"
      self        = true
    }
  }

  node_iam_role_additional_policies = {
    AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    EC2FullAccess            = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  }

  saha_nodes_instance_type = "t3a.large"
  saha_nodes_min_size      = 0
  saha_nodes_max_size      = 5
  # This value is ignored after the initial creation
  # https://github.com/bryantbiggs/eks-desired-size-hack
  saha_nodes_desired_size      = 1
  saha_nodes_enable_monitoring = true

  devops_nodes_instance_type = "t3a.xlarge"
  devops_nodes_min_size      = 1
  devops_nodes_max_size      = 5
  # This value is ignored after the initial creation
  # https://github.com/bryantbiggs/eks-desired-size-hack
  devops_nodes_desired_size      = 1
  devops_nodes_enable_monitoring = true

  tags = {
    project       = "Brigge"
    region        = "eu-west-1"
    env           = "dev"
    owner         = "Brigge"
    user-mode     = "dedicated"
    TerraformRoot = "https://github.com/Alizandieh/tf-infra.git/eu-west-1-saha-dev"
  }
}
