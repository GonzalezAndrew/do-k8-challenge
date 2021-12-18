terraform {
  required_version = ">= 0.15.1, < 1.1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
}

module "k8" {
  source         = "./modules/kubernetes-cluster"
  cluster_name   = "ds9"
  node_pool_name = "default"
  node_count     = 2
}

module "k8-config" {
  source                 = "./modules/kubernetes-config"
  cluster_name           = module.k8.cluster_name
  cluster_id             = module.k8.cluster_id
  kube_config            = module.k8.kube_config
  host                   = module.k8.cluster_endpoint
  token                  = module.k8.token
  cluster_ca_certificate = module.k8.cluster_ca_certificate
}
