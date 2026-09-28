module "ecr_repository_backend" {
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name         = "saha-backend"
  repository_type         = "private"
  create_lifecycle_policy = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

############################################
module "ecr_repository_backend_prod" {
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name         = "saha-backend-prod"
  repository_type         = "private"
  create_lifecycle_policy = true

  # Registry Replication Configuration
  create_registry_replication_configuration = true
  registry_replication_rules = [{
    destinations = [{
      region      = "eu-west-1"
      registry_id = "033504885888" # AWS Account ID (PROD)
    }]

    repository_filters = [{
      filter      = "saha-backend-prod"
      filter_type = "PREFIX_MATCH"
      },
      {
        filter      = "test-repo"
        filter_type = "PREFIX_MATCH"
    }]
  }]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

############################################
module "ecr_repository_test" {
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name         = "test-repo"
  repository_type         = "private"
  create_lifecycle_policy = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

############################################
module "ecr_repository_cache" {
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name                 = "cache"
  repository_type                 = "private"
  repository_image_tag_mutability = "MUTABLE"
  create_lifecycle_policy         = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}


############################################
# Public Repos
############################################
module "ecr_repository_devops" {

  providers = {
    aws = aws.us-region
  }
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name         = "devops"
  repository_type         = "public"
  create_lifecycle_policy = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

############################################
module "ecr_repository_code_runner" {

  providers = {
    aws = aws.us-region
  }
  # source  = "terraform-aws-modules/ecr/aws"
  # version = "3.1.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr?ref=01c469738d8196787b944273bd11a06fff6867ab"

  repository_name         = "code-runner"
  repository_type         = "public"
  create_lifecycle_policy = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
