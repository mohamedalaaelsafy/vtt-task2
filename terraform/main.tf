module "cloud_run" {
  source     = "./modules/cloud-run"
  project_id = var.project_id
  region     = var.region
  name       = var.name
  cpu        = var.cpu
  memory     = var.memory
  minScale   = var.minScale
  maxScale   = var.maxScale
}