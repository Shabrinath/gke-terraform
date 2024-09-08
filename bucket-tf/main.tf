provider "google" {
  project     = "terraform1-434800"
  region      = "us-central1"
}

module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 6.1"
  project_id  = "terraform1-434800"
  names = ["data-bucket", "dums-bucket"]
  prefix = "my-unique-prefix"
#  set_admin_roles = true
#  admins = ["group:foo-admins@example.com"]
#  versioning = {
#    first = true
#  }
#  bucket_admins = {
#    second = "user:spam@example.com,user:eggs@example.com"
#  }
}
