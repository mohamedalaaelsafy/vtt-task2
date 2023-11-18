#To get project number
data "google_project" "project" {
    project_id = var.project_id
}

data "google_iam_policy" "iap-auth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:service-${data.google_project.project.number}@gcp-sa-iap.iam.gserviceaccount.com",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location    = google_cloud_run_service.python-app.location
  project     = google_cloud_run_service.python-app.project
  service     = google_cloud_run_service.python-app.name
  policy_data = data.google_iam_policy.iap-auth.policy_data
  depends_on = [ google_cloud_run_service.python-app ]
}


