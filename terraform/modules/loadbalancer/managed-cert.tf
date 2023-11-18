resource "google_compute_managed_ssl_certificate" "default" {
  name = "vtt-cert"

  managed {
    domains = ["python.ma-devops.com"]
  }
  depends_on = [ google_compute_global_address.global_alb_ip ]
}
