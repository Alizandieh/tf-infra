module "saha_lightsail" {
  source            = "git@github.com:Alizandieh/tf-modules.git//modules/lightsail?ref=fc0b0cc"
  ssh_key_name      = "kuma_ssh"
  instance_name     = "uptime-kuma"
  availability_zone = "eu-west-1a"
  blueprint_id      = "ubuntu_24_04"
  bundle_id         = "micro_3_0"
  static_ip_name    = "uptime-kuma-ip"
  disk_name         = "uptime-kuma-disk"
  disk_size         = 8
  user_data         = <<-EOT
#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl enable docker
systemctl start docker
EOT
}
