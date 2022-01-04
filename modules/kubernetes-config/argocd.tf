resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_version

  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }

  depends_on = [
    kubernetes_namespace.argocd
  ]
}
