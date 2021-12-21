resource "local_file" "kubeconfig" {
  depends_on = [
    var.cluster_id
  ]
  count    = var.write_kubeconfig ? 1 : 0
  content  = var.kube_config
  filename = join("/", [path.module, "kubeconfig"])
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}
