<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.52.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.52.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_base"></a> [base](#module\_base) | git@github.com:Alizandieh/tf-modules.git//modules/base | 8d305dd |
| <a name="module_brigge_lightsail"></a> [brigge\_lightsail](#module\_brigge\_lightsail) | git@github.com:Alizandieh/tf-modules.git//modules/lightsail | 8d305dd |
| <a name="module_db_dev"></a> [db\_dev](#module\_db\_dev) | git::https://github.com/terraform-aws-modules/terraform-aws-rds | 592cd8b2450018b1017b309d82e7eef8cb3ee14c |
| <a name="module_db_dev_landlord"></a> [db\_dev\_landlord](#module\_db\_dev\_landlord) | git::https://github.com/terraform-aws-modules/terraform-aws-rds | 592cd8b2450018b1017b309d82e7eef8cb3ee14c |
| <a name="module_db_dev_landlord_read_replica"></a> [db\_dev\_landlord\_read\_replica](#module\_db\_dev\_landlord\_read\_replica) | git::https://github.com/terraform-aws-modules/terraform-aws-rds | 592cd8b2450018b1017b309d82e7eef8cb3ee14c |
| <a name="module_db_dev_read_replica"></a> [db\_dev\_read\_replica](#module\_db\_dev\_read\_replica) | git::https://github.com/terraform-aws-modules/terraform-aws-rds | 592cd8b2450018b1017b309d82e7eef8cb3ee14c |
| <a name="module_ecr_repository_backend"></a> [ecr\_repository\_backend](#module\_ecr\_repository\_backend) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_ecr_repository_backend_prod"></a> [ecr\_repository\_backend\_prod](#module\_ecr\_repository\_backend\_prod) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_ecr_repository_cache"></a> [ecr\_repository\_cache](#module\_ecr\_repository\_cache) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_ecr_repository_code_runner"></a> [ecr\_repository\_code\_runner](#module\_ecr\_repository\_code\_runner) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_ecr_repository_devops"></a> [ecr\_repository\_devops](#module\_ecr\_repository\_devops) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_ecr_repository_test"></a> [ecr\_repository\_test](#module\_ecr\_repository\_test) | git::https://github.com/terraform-aws-modules/terraform-aws-ecr | 01c469738d8196787b944273bd11a06fff6867ab |
| <a name="module_rds_alerts"></a> [rds\_alerts](#module\_rds\_alerts) | git@github.com:Alizandieh/tf-modules.git//modules/RDS_events_alert | 8d305dd |
| <a name="module_saha_bucket"></a> [saha\_bucket](#module\_saha\_bucket) | git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket | 0662a7bdfceac73daed7c08df2b421707de341df |
| <a name="module_saha_bucket_uat"></a> [saha\_bucket\_uat](#module\_saha\_bucket\_uat) | git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket | 0662a7bdfceac73daed7c08df2b421707de341df |
| <a name="module_saha_bucket_velero"></a> [saha\_bucket\_velero](#module\_saha\_bucket\_velero) | git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket | 0662a7bdfceac73daed7c08df2b421707de341df |
| <a name="module_saha_dashboard_cache"></a> [saha\_dashboard\_cache](#module\_saha\_dashboard\_cache) | git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket | 0662a7bdfceac73daed7c08df2b421707de341df |
| <a name="module_saha_eks"></a> [saha\_eks](#module\_saha\_eks) | git@github.com:Alizandieh/tf-modules.git//modules/EKS | 8d305dd |
| <a name="module_saha_iam"></a> [saha\_iam](#module\_saha\_iam) | git@github.com:Alizandieh/tf-modules.git//modules/IAM | 8d305dd |
| <a name="module_saha_ses_cloudflare"></a> [saha\_ses\_cloudflare](#module\_saha\_ses\_cloudflare) | git@github.com:Alizandieh/tf-modules.git//modules/ses | ace3eba |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git::https://github.com/terraform-aws-modules/terraform-aws-security-group | badbab67cd0d7f976523fd44647e1ee9fb87001b |
| <a name="module_uat_documentdb"></a> [uat\_documentdb](#module\_uat\_documentdb) | git::https://github.com/cloudposse/terraform-aws-documentdb-cluster | 6de223582b8caa9c6158db3938d42b2a3b2c5a08 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_event_rule.ecr_vuln_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.send_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_db_subnet_group.db_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.eventsaha_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.eventsaha_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_route.peering](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.peering_us](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_sns_topic.ecr_vuln_alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.allow_eventbridge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.email_sub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.s3_private_velero_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_public_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_public_read_policy_uat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The list of availability zones the VPC sits within. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes version for the cluster |
| <a name="output_lightsail_instance_static_ip"></a> [lightsail\_instance\_static\_ip](#output\_lightsail\_instance\_static\_ip) | n/a |
| <a name="output_subnet_cidrs"></a> [subnet\_cidrs](#output\_subnet\_cidrs) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->
