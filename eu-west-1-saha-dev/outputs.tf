output "availability_zones" {
  description = "The list of availability zones the VPC sits within."
  value       = module.base.availability_zones
}

output "subnets" {
  value = module.base.subnets
}

output "subnet_cidrs" {
  value = module.base.subnet_cidrs
}

output "vpc_id" {
  value = module.base.vpc_id
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.saha_eks.cluster_name
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = module.saha_eks.cluster_version
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.saha_eks.cluster_endpoint
}

#output "db_instance_address" {
#  description = "The address of the RDS instance"
#  value       = try(module.db.db_instance_address, null)
#}
#
#output "db_instance_endpoint" {
#  description = "The connection endpoint"
#  value       = try(module.db.db_instance_endpoint, null)
#}

output "lightsail_instance_static_ip" {
  value = try(module.saha_lightsail.static_ip, null)
}

#output "lightsail_instance_ssh_public_key" {
#  description = "Public key of the Lightsail SSH key pair"
#  value       = try(module.saha_lightsail.ssh_public_key, null)
#}
#
#output "lightsail_instance_ssh_private_key" {
#  description = "Private key of the Lightsail SSH key pair"
#  value       = try(module.saha_lightsail.ssh_private_key, null)
#}
