data "digitalocean_kubernetes_versions" "this" {}
resource "digitalocean_kubernetes_cluster" "this" {
  name    = var.cluster_name
  region  = var.region
  version = data.digitalocean_kubernetes_versions.this.latest_version

  node_pool {
    name       = var.node_pool_name
    size       = var.node_size
    node_count = var.node_count
  }
}

resource "digitalocean_project" "this" {
  name        = var.project_name
  description = var.project_description
  resources   = [digitalocean_kubernetes_cluster.this.urn]
}
