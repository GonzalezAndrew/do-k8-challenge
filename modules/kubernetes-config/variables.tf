variable "cluster_name" {
  description = "A name for the Kubernetes cluster."
  type        = string
}

variable "cluster_id" {
  description = "A unique ID that can be used to identify and reference a Kubernetes cluster."
  type        = string
}

variable "host" {
  description = "The base URL of the API server on the Kubernetes master node."
  type        = string
}

variable "token" {
  description = "The DigitalOcean API access token used by clients to access the cluster."
}

variable "cluster_ca_certificate" {
  description = "The base64 encoded public certificate for the cluster's certificate authority."
}

variable "kube_config" {
  description = "The full contents of the Kubernetes cluster's kubeconfig file."
}

variable "argo_version" {
  description = "The version of Argo to install."
  type        = string
  default     = "3.13.0"
}
