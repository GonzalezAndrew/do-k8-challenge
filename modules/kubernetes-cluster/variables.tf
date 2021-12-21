variable "region" {
  description = "The region to deploy to."
  default     = "nyc3"
  type        = string
}

variable "cluster_name" {
  description = "A name for the Kubernetes cluster."
  default     = "voyager"
  type        = string
}

variable "node_pool_name" {
  description = "A name for the node pool."
  default     = "default"
  type        = string
}

variable "node_size" {
  description = "The slug identifier for the type of Droplet to be used as workers in the node pool."
  default     = "s-1vcpu-2gb"
  type        = string
}

variable "node_count" {
  description = "The number of Droplet instances in the node pool. If auto-scaling is enabled, this should only be set if the desired result is to explicitly reset the number of nodes to this value. If auto-scaling is enabled, and the node count is outside of the given min/max range, it will use the min nodes value."
  default     = 1
  type        = number
}

variable "project_name" {
  description = "The name of the Project"
  type        = string
  default     = "DigitalOcean K8 Challenge"
}

variable "project_description" {
  description = "The description of the project."
  type        = string
  default     = "A project for the DigitalOcean K8 Challenge."
}
