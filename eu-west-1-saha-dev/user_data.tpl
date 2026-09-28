--MIMEBOUNDARY
Content-Transfer-Encoding: 7bit
Content-Type: text/x-shellscript; charset="us-ascii"
Mime-Version: 1.0

#!/bin/bash

# Get instance ID and region from instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region)

# Disable source/destination check for this instance (used for things like Calico CNI)
aws ec2 modify-instance-attribute --instance-id "$INSTANCE_ID" --no-source-dest-check --region "$REGION"

export INSTANCE_NAME=$(aws ec2 describe-tags \
  --region "$REGION" \
  --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=Name" \
  --query "Tags[0].Value" \
  --output text)

mkdir -p /etc/nodeadm

cat <<EOF >/etc/nodeadm/node-config.yaml
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${cluster_name}
    apiServerEndpoint: "${cluster_endpoint}"
    certificateAuthority: "${cluster_auth_base64}"
    cidr: ${cluster_service_cidr}
  kubelet:
    config:
      maxPods: 100
    flags:
    - --node-labels=node-group=$INSTANCE_NAME
EOF

nodeadm init -c file:///etc/nodeadm/node-config.yaml
