# https://istio.io/latest/docs/setup/install/helm/
resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

# https://istio.io/latest/docs/setup/additional-setup/gateway/
resource "kubernetes_namespace" "istio_ingress" {
  metadata {
    name = "istio-ingress"
  }
}

# install the istio base chart which contains cluster-wide resources used by the Istio control pane
resource "helm_release" "istio_base" {
  name      = "istio-base"
  namespace = kubernetes_namespace.istio_system.metadata.name

  chart      = "base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  version    = "1.12.1"
  depends_on = [
    kubernetes_namespace.istio_system
  ]
}

# install istio discovery chart which deploys the istiod service
resource "helm_release" "istiod" {
  name      = "istiod"
  namespace = kubernetes_namespace.istio_system.metadata.name

  chart      = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  version    = "1.12.1"
  atomic     = true
  depends_on = [
    helm_release.istio_base
  ]
}

# install an ingress gateway
resource "helm_release" "istio_ingress" {
  name      = "istio-ingress"
  namespace = kubernetes_namespace.istio_ingress.metadata.name

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = "1.12.1"

  atomic = true

  depends_on = [helm_release.istiod, kubernetes_namespace.istio_ingress]
}


# https://istio.io/latest/docs/ops/integrations/prometheus/
data "http" "istio_prometheus_manifest" {
  url = "https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/prometheus.yaml"
}

data "kubectl_file_documents" "istio_prometheus_docs" {
  content = data.http.istio_prometheus_manifest.body
}

resource "kubectl_manifest" "istio_prometheus" {
  for_each  = data.kubectl_file_documents.istio_prometheus_docs.manifests
  yaml_body = each.value

  override_namespace = "istio-system"

  depends_on = [helm_release.istiod]
}
