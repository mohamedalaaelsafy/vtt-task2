module "lb-http" {
  source                          = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version                         = "~> 9.0"
  project                         = var.project_id
  name                            = var.alb_name
  ssl                             = true
  ssl_certificates                = ["https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/sslCertificates/vtt-cert"]
  use_ssl_certificates            = true
  https_redirect                  = true
  # managed_ssl_certificate_domains = ["python.ma-devops.com"]
  create_address                  = false
  address                         = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/addresses/${var.alb_ip_name}"

  backends = {
    default = {
      description             = null
      protocol                = "HTTP"
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = null
      compression_mode        = null
      log_config = {
        enable      = false
        sample_rate = 1.0
      }
      groups = [
        {
          group = var.serverless_neg
        }
      ]
      iap_config = {
        enable               = true
        oauth2_client_id     = var.oauth2_client_id
        oauth2_client_secret = var.oauth2_client_secret
      }
    }
  }
  depends_on = [google_compute_global_address.global_alb_ip, google_compute_managed_ssl_certificate.default ]
}


