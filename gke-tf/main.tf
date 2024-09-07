provider "google" {
  project = "terraform1-434800"
  region  = "us-central1"
}


module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "terraform1-434800"
  name                       = "gke-test-1"
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = "custom-network"
  subnetwork                 = "custom-subnet"
  ip_range_pods              = "pods-range"
  ip_range_services          = "services-range"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false

  node_pools = [
    {
      name                        = "default-node-pool"
      machine_type                = "e2-medium"
      node_locations              = "us-central1-b,us-central1-c"
      node_count                  = 5
      autoscaling                 = false
      min_count                   = 1
      max_count                   = 6
      local_ssd_count             = 0
      spot                        = false
      disk_size_gb                = 10
      disk_type                   = "pd-standard"
      image_type                  = "COS_CONTAINERD"
      enable_gcfs                 = false
      enable_gvnic                = false
      logging_variant             = "DEFAULT"
      auto_repair                 = true
      auto_upgrade                = true
      service_account_name        = "project-service-account@terraform1-434800.iam.gserviceaccount.com"
      preemptible                 = false
 #     initial_node_count          = 3
 #     accelerator_count           = 1
 #     accelerator_type            = "nvidia-l4"
 #     gpu_driver_version          = "LATEST"
 #     gpu_sharing_strategy        = "TIME_SHARING"
 #     max_shared_clients_per_gpu = 2
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
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

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
