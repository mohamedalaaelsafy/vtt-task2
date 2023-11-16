module "cloud-run-sa" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 3.0"
  project_id = var.project_id
  names      = ["cloud-run-sa"]
  project_roles = [
    "${var.project_id}=>roles/artifactregistry.admin",
    "${var.project_id}=>roles/run.admin",
    "${var.project_id}=>roles/iam.serviceAccountUser"
  ]
}