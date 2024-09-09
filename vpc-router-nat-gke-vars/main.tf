provider "google" {
  project = var.project_id
  region  = var.region
}

#create Network and Subnet
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = var.routing_mode

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = var.subnet_ip
      subnet_region = var.subnet_region
    }
  ]

  secondary_ranges = {
    "${var.subnet_name}" = [
      {
        range_name    = "pods-range"
        ip_cidr_range = var.pods_range_cidr
      },
      {
        range_name    = "services-range"
        ip_cidr_range = var.services_range_cidr
      }
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = true
    }
  ]
}

#create router
module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 6.0"

  name    = "custom-router"
  region  = var.region

  project = var.project_id
  network = var.network_name
  depends_on = [module.vpc]
}

#create Cloud NAT
module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  project_id = var.project_id
  region     = var.region
  router     = "custom-router"
  depends_on = [module.vpc, module.cloud_router]
}

#create GKE cluster
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.gke_cluster_name
  region                     = var.region
  zones                      = var.gke_zones
  network                    = var.network_name
  subnetwork                 = var.subnet_name
  ip_range_pods              = "pods-range"
  ip_range_services          = "services-range"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false
  deletion_protection        = false
  depends_on                 = [module.vpc]

  node_pools = [
    {
      name              = "default-node-pool"
      machine_type      = var.machine_type
      node_locations    = join(",", var.gke_zones)
      node_count        = var.node_count
      autoscaling       = false
      min_count         = 1
      max_count         = 3
      local_ssd_count   = 0
      spot              = false
      disk_size_gb      = var.disk_size_gb
      disk_type         = var.disk_type
      image_type        = "COS_CONTAINERD"
      enable_gcfs       = false
      enable_gvnic      = false
      logging_variant   = "DEFAULT"
      auto_repair       = true
      auto_upgrade      = true
      service_account_name = var.service_account_name
      preemptible       = false
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = var.node_pool_taints
  }

  node_pools_tags = {
    all = []

    default-node-pool = var.node_pool_tags
  }
}

