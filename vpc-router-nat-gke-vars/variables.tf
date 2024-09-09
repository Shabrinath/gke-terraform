variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "network_name" {
  description = "The name of the network"
  type        = string
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "GLOBAL"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_ip" {
  description = "The CIDR range of the subnet"
  type        = string
}

variable "subnet_region" {
  description = "The region of the subnet"
  type        = string
}

variable "pods_range_cidr" {
  description = "Secondary IP range for Pods"
  type        = string
}

variable "services_range_cidr" {
  description = "Secondary IP range for Services"
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "gke_zones" {
  description = "The zones of the GKE cluster"
  type        = list(string)
}

variable "machine_type" {
  description = "The machine type for the GKE node pool"
  type        = string
}

variable "node_count" {
  description = "Initial node count for the GKE node pool"
  type        = number
}

variable "disk_size_gb" {
  description = "Disk size for each node in the GKE node pool"
  type        = number
}

variable "disk_type" {
  description = "Disk type for each node in the GKE node pool"
  type        = string
}

variable "service_account_name" {
  description = "Service account for the GKE node pool"
  type        = string
}

variable "node_pool_taints" {
  description = "Taints for the node pool"
  type        = list(map(string))
}

variable "node_pool_tags" {
  description = "Tags for the node pool"
  type        = list(string)
}

