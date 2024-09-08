Create SA in GCP console and assign roles per #https://github.com/Shabrinath/terraform-google-kubernetes-engine?tab=readme-ov-file#configure-a-service-account
Generate and Download keys in GCP console
export GOOGLE_CREDENTIALS="/root/gcp_sa_creds.json"
git clone
cd gke-terraform/tf-network
  terraform init
  terraform apply
cd gke-terraform/tf-gke
  terraform init
  terraform apply
  

