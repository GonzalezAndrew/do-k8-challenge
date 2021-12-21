provider "kubernetes" {
  host                   = var.host
  token                  = var.token
  cluster_ca_certificate = var.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = var.host
    token                  = var.token
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}

provider "kubectl" {
  host                   = var.host
  token                  = var.token
  cluster_ca_certificate = var.cluster_ca_certificate
  load_config_file       = false
  apply_retry_count      = 5
}
