module "saha_ses_cloudflare" {
  source = "git@github.com:Alizandieh/tf-modules.git//modules/ses?ref=ace3eba"

  domain_name       = "brigge.ai"
  cloudflare_domain = true
  zone_id           = "180960994600855ea567dfd9b73346f9"
  verify_dkim       = true
  dmarc_enabled     = true
  spf_enabled       = true
  create_smtp_user  = true
  smtp_secret_name  = "SMTP1"
}
