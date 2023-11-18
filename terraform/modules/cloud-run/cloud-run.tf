resource "google_cloud_run_service" "python-app" {
  name     = var.name
  location = var.region

  template {
    spec {
      containers {
        # image = "us-docker.pkg.dev/cloudrun/container/hello"
        image = "us-central1-docker.pkg.dev/vodafone-technical-task/dev/python-app"
        ports {
          container_port = 80
          name           = "http1"
        }
        resources {
          limits = {
            "cpu"    = var.cpu
            "memory" = var.memory
          }
        }

      }

      container_concurrency = 80
      service_account_name  = module.cloud-run-sa.email
      timeout_seconds       = 300
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = var.minScale
        "autoscaling.knative.dev/maxScale" = var.maxScale
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
  }
  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].metadata[0].annotations,
      template[0].metadata[0].labels
    ]
  }

  autogenerate_revision_name = true
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth-policy" {
  location = google_cloud_run_service.python-app.location
  project  = google_cloud_run_service.python-app.project
  service  = google_cloud_run_service.python-app.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "python-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.python-app.name
  }
}


