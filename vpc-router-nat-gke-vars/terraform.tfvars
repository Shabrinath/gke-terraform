project_id            = "terraform1-434800"
region                = "us-central1"
network_name          = "custom-network"
routing_mode          = "GLOBAL"
subnet_name           = "custom-subnet-01"
subnet_ip             = "10.0.0.0/16"
subnet_region         = "us-central1"
pods_range_cidr       = "10.1.0.0/16"
services_range_cidr   = "10.2.0.0/16"
gke_cluster_name      = "gke-test-1"
gke_zones             = ["us-central1-a", "us-central1-b", "us-central1-f"]
machine_type          = "e2-medium"
node_count            = 2
disk_size_gb          = 10
disk_type             = "pd-standard"
service_account_name  = "project-service-account@terraform1-434800.iam.gserviceaccount.com"
node_pool_taints      = [{ key = "default-node-pool", value = "true", effect = "PREFER_NO_SCHEDULE" }]
node_pool_tags        = ["default-node-pool"]

