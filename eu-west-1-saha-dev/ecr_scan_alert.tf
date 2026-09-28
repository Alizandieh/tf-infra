# SNS topic for vulnerability alerts
resource "aws_sns_topic" "ecr_vuln_alerts" {
  name = "ecr-vulnerability-alerts"
}

# Email subscription
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.ecr_vuln_alerts.arn
  protocol  = "email"
  endpoint  = "ali.zandieh@gmail.com"
}

# EventBridge rule: triggers only for saha-backend ECR repo
resource "aws_cloudwatch_event_rule" "ecr_vuln_rule" {
  name        = "ecr-vulnerability-rule"
  description = "Trigger when ECR image scan finds a high or critical vulnerability in saha-backend"

  event_pattern = jsonencode({
    "source" : ["aws.ecr"],
    "detail-type" : ["ECR Image Scan"],
    "detail" : {
      "scan-status" : ["COMPLETE"],
      "repository-name" : ["saha-backend-prod"],
      "$or" : [
        { "finding-severity-counts" : { "HIGH" : [{ "exists" : true }] } },
        { "finding-severity-counts" : { "CRITICAL" : [{ "exists" : true }] } }
      ]
    }
  })
}

# IAM role for EventBridge to publish to SNS
resource "aws_iam_role" "eventsaha_to_sns" {
  name = "eventsaha-to-sns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach a policy allowing publishing to the SNS topic
resource "aws_iam_role_policy" "eventsaha_publish_policy" {
  name = "eventsaha-publish-to-sns"
  role = aws_iam_role.eventsaha_to_sns.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = aws_sns_topic.ecr_vuln_alerts.arn
      }
    ]
  })
}

# SNS topic policy allowing the IAM role to publish
resource "aws_sns_topic_policy" "allow_eventbridge" {
  arn = aws_sns_topic.ecr_vuln_alerts.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.eventsaha_to_sns.arn
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.ecr_vuln_alerts.arn
      }
    ]
  })
}

# EventBridge target to send event to SNS topic
resource "aws_cloudwatch_event_target" "send_to_sns" {
  rule      = aws_cloudwatch_event_rule.ecr_vuln_rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.ecr_vuln_alerts.arn
  role_arn  = aws_iam_role.eventsaha_to_sns.arn

  input_transformer {
    input_paths = {
      repository = "$.detail.repository-name"
      tag        = "$.detail.image-tags[0]"
      status     = "$.detail.scan-status"
      findings   = "$.detail.finding-severity-counts"
      time       = "$.time"
      region     = "$.region"
      account    = "$.account"
    }

    input_template = <<-EOF
"ECR Vulnerability Scan Alert"
"Scan Status: <status>"
"Time: <time>"
"Account: <account>"
"Region: <region>"
"Repository : <repository>"
"Image Tag: <tag>"
"Findings: <findings>"
EOF
  }
}
