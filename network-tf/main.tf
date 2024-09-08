provider "google" {
#  credentials = file("<path-to-your-service-account-key>.json")
  project     = "terraform1-434800"
  region      = "us-central1"
}

# Create a custom VPC network
resource "google_compute_network" "vpc_network" {
  name                    = "custom-network"
  auto_create_subnetworks  = false  # Set to false for custom subnets
  routing_mode             = "GLOBAL" # Optional: GLOBAL or REGIONAL
}

# Create a custom subnetwork within the VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name

  # Optional: Secondary ranges for GKE, etc.
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.2.0.0/20"
  }
}

