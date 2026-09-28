module "uat_documentdb" {
  # source = "cloudposse/documentdb-cluster/aws"
  # version = "~> 1.0.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/cloudposse/terraform-aws-documentdb-cluster?ref=6de223582b8caa9c6158db3938d42b2a3b2c5a08"

  stage                       = "uat"
  name                        = "saha_docdb"
  cluster_family              = "docdb5.0"
  engine_version              = "5.0.0"
  cluster_size                = 1
  instance_class              = "db.t4g.medium"
  manage_master_user_password = true
  vpc_id                      = module.base.vpc_id
  subnet_ids                  = module.base.subnets["private"]
  allowed_security_groups     = [module.saha_eks.node_security_group_id]
}
