module "saha_iam" {
  source = "git@github.com:Alizandieh/tf-modules.git//modules/IAM?ref=fc0b0cc"

  cluster_name          = module.saha_eks.cluster_name
  cert_manager_role     = true
  external_dns_role     = true
  external_secrets_role = true
  karpenter_role        = true
  saha_s3_role          = true
  velero_role           = true
  grafana_role          = true
  velero_bucket_name    = module.saha_bucket_velero.s3_bucket_id
  saha_bucket_name      = module.saha_bucket.s3_bucket_id
  saha_namespace        = "saha-dev"

  loki_s3_role = false
  # loki_chunks_bucket_name = module.s3_bucket_loki_chunks.s3_bucket_id
  # loki_ruler_bucket_name  = module.s3_bucket_loki_ruler.s3_bucket_id
}
