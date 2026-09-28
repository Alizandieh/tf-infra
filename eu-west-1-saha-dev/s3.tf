#########################################
# DEV
#########################################
module "saha_bucket" {
  # source = "terraform-aws-modules/s3-bucket/aws"
  # version = "5.9.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=0662a7bdfceac73daed7c08df2b421707de341df"

  bucket                  = "saha-backend-bucket"
  acl                     = "public-read"
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_public_read_policy.json

  versioning = {
    enabled = false
  }
}

data "aws_iam_policy_document" "s3_public_read_policy" {
  statement {
    sid    = "PublicRead"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${module.saha_bucket.s3_bucket_arn}/*"]
  }
}

#########################################
# UAT
#########################################
module "saha_bucket_uat" {
  # source = "terraform-aws-modules/s3-bucket/aws"
  # version = "5.9.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=0662a7bdfceac73daed7c08df2b421707de341df"

  bucket                  = "saha-backend-bucket-uat"
  acl                     = "public-read"
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_public_read_policy_uat.json

  versioning = {
    enabled = false
  }
}

data "aws_iam_policy_document" "s3_public_read_policy_uat" {
  statement {
    sid    = "PublicRead"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${module.saha_bucket_uat.s3_bucket_arn}/*"]
  }
}

#########################################
# VELERO
#########################################
module "saha_bucket_velero" {
  # source = "terraform-aws-modules/s3-bucket/aws"
  # version = "5.9.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=0662a7bdfceac73daed7c08df2b421707de341df"

  bucket                  = "saha-velero-backups"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_private_velero_policy.json

  versioning = {
    enabled = false
  }
}

data "aws_iam_policy_document" "s3_private_velero_policy" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]
    resources = [
      module.saha_bucket_velero.s3_bucket_arn,
      "${module.saha_bucket_velero.s3_bucket_arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }

  }
}


#########################################
# Frontend (Dashboard) cache
#########################################
module "saha_dashboard_cache" {
  # source  = "terraform-aws-modules/s3-bucket/aws"
  # version = "5.9.0"
  # for extra security using the commit hash of version
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=0662a7bdfceac73daed7c08df2b421707de341df"

  bucket                  = "saha-dashboard-cache"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = false

  versioning = {
    enabled = false
  }
}
