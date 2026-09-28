resource "aws_db_subnet_group" "db_subnets" {
  name       = "rds-db-subnet-group"
  subnet_ids = module.base.subnets["private"]
}

module "security_group" {
  # source  = "terraform-aws-modules/security-group/aws"
  # version = "~> 5.3.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group?ref=badbab67cd0d7f976523fd44647e1ee9fb87001b"

  name        = "saha_database"
  description = "DB security group"
  vpc_id      = module.base.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "DB access from EU VPC"
      cidr_blocks = "10.62.0.0/16"
    },
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "DB access from US VPC"
      cidr_blocks = "10.63.0.0/18"
    }
  ]
}

#########################################
# DEV (Tenants)
#########################################
module "db_dev" {
  # source  = "terraform-aws-modules/rds/aws"
  # version = "7.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds?ref=592cd8b2450018b1017b309d82e7eef8cb3ee14c"

  identifier = "eu-west-1-saha-dev"

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mariadb"
  engine_version       = "11.4.10"
  family               = "mariadb11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t3.micro"


  allocated_storage     = 20
  max_allocated_storage = 100

  username                    = "admin"
  manage_master_user_password = false
  password_wo                 = "testpass"
  password_wo_version         = 1
  port                        = 3306
  multi_az                    = false
  db_subnet_group_name        = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids      = [module.security_group.security_group_id]

  maintenance_window              = "Tue:08:30-Tue:09:00"
  backup_window                   = "03:00-06:00"
  backup_retention_period         = 7
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = false

  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = false
  parameters = [
    {
      name  = "innodb_file_per_table"
      value = "0"
    }
  ]
}

#########################################
# DEV (Landlord)
#########################################
module "db_dev_landlord" {
  # source  = "terraform-aws-modules/rds/aws"
  # version = "7.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds?ref=592cd8b2450018b1017b309d82e7eef8cb3ee14c"

  identifier = "eu-west-1-saha-dev-landlord"

  engine               = "mariadb"
  engine_version       = "11.4.10"
  family               = "mariadb11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t3.micro"


  allocated_storage     = 20
  max_allocated_storage = 100

  db_name                     = "landlord"
  username                    = "admin"
  manage_master_user_password = false
  password_wo                 = "testpass"
  password_wo_version         = 1
  port                        = 3306
  multi_az                    = false
  db_subnet_group_name        = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids      = [module.security_group.security_group_id]

  maintenance_window              = "Tue:08:30-Tue:09:00"
  backup_window                   = "03:00-06:00"
  backup_retention_period         = 7
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = false

  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = false

}


# -------------------------------
# DEV Tenants Read Replica
# -------------------------------
module "db_dev_read_replica" {
  source     = "git::https://github.com/terraform-aws-modules/terraform-aws-rds?ref=592cd8b2450018b1017b309d82e7eef8cb3ee14c"
  identifier = "eu-west-1-saha-dev-replica"
  # Read replica specific
  replicate_source_db  = module.db_dev.db_instance_arn
  engine               = "mariadb"
  engine_version       = "11.4.10"
  family               = "mariadb11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t3.micro"
  publicly_accessible  = false
  # Same network and security
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [module.security_group.security_group_id]
  # Optional settings (inherit automatically from source)
  skip_final_snapshot   = true
  deletion_protection   = false
  max_allocated_storage = 100
  maintenance_window    = "Tue:08:00-Tue:08:30"
}

# -------------------------------
# DEV Landlord Read Replica
# -------------------------------
module "db_dev_landlord_read_replica" {
  source     = "git::https://github.com/terraform-aws-modules/terraform-aws-rds?ref=592cd8b2450018b1017b309d82e7eef8cb3ee14c"
  identifier = "eu-west-1-saha-dev-landlord-replica"
  # Read replica specific
  replicate_source_db  = module.db_dev_landlord.db_instance_arn
  engine               = "mariadb"
  engine_version       = "11.4.10"
  family               = "mariadb11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t3.micro"
  publicly_accessible  = false
  availability_zone    = "eu-west-1b"
  # Same network and security
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [module.security_group.security_group_id]
  # Optional settings (inherit automatically from source)
  skip_final_snapshot   = true
  deletion_protection   = false
  max_allocated_storage = 100
  maintenance_window    = "Tue:08:00-Tue:08:30"
}
