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
  source         = "./kubernetes-cluster"
  node_pool_name = "default"
  node_count     = 2
}

module "k8-config" {
  source       = "./kubernetes-config"
  cluster_name = module.k8.cluster_name
  cluster_id   = module.k8.cluster_id
}
