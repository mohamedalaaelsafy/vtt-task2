module "cloud-run-sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  names         = ["cloud-run-sa"]
  project_roles = []
}