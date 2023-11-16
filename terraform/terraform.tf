terraform {
  backend "gcs" {
    bucket = "kube-terraform-bucket"
    prefix = "vtt-task2"
  }
}

provider "google" {
  project = "vodafone-technical-task"
  region  = "us-central1"
}