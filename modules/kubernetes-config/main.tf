# resource "local_file" "kubeconfig" {
#   depends_on = [
#     var.cluster_id
#   ]
#   content  = var.kube_config
#   filename = join("/", [path.module, "kubeconfig.yaml"])
# }

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.13.0"

  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }

  depends_on = [
    kubernetes_namespace.argocd
  ]
}
