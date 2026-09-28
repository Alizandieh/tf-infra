terraform {
  required_version = ">= 1.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.52.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }

  backend "s3" {
    bucket       = "tf-state-saha-dev"
    key          = "base.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}

#provider "cloudflare" {
#  api_token = "1235456"
#}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      project       = "SAHA"
      region        = "eu-west-1"
      env           = "dev"
      owner         = "SAHA"
      user-mode     = "dedicated"
      TerraformRoot = "https://github.com/Alizandieh/tf-infra.git/eu-west-1-saha-dev"
    }
  }
}

# This is used for creating public ECR because they're only available in this region.
provider "aws" {
  alias  = "us-region"
  region = "us-east-1"

  default_tags {
    tags = {
      project       = "SAHA"
      region        = "us-east-1"
      env           = "dev"
      owner         = "SAHA"
      user-mode     = "dedicated"
      TerraformRoot = "https://github.com/Alizandieh/tf-infra.git/eu-west-1-saha-dev"
    }
  }
}
