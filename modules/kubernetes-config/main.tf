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
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [
    var.cluster_id
  ]
  count    = var.write_kubeconfig ? 1 : 0
  content  = var.kube_config
  filename = join("/", [path.module, "kubeconfig"])
}

provider "kubernetes" {
  host  = var.host
  token = var.token
  cluster_ca_certificate = base64decode(
    var.cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = var.host
    token = var.token
    cluster_ca_certificate = base64decode(
      var.cluster_ca_certificate
    )
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}
