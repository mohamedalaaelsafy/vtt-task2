module "cloud_run" {
  source      = "./modules/cloud-run"
  project_id  = var.project_id
  region      = var.region
  name        = var.name
  cpu         = var.cpu
  memory      = var.memory
  minScale    = var.minScale
  maxScale    = var.maxScale
}

module "loadbalancer" {
  source         = "./modules/loadbalancer"
  project_id     = var.project_id
  alb_name       = var.alb_name
  alb_ip_enabled = var.alb_ip_enabled
  alb_ip_name    = var.alb_ip_name
  serverless_neg = module.cloud_run.serverless_neg

  depends_on = [module.cloud_run]
}