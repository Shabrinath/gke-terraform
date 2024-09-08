
# GKE Terraform Deployment

This repository provides a Terraform-based approach to set up a Google Kubernetes Engine (GKE) cluster along with the necessary network configurations.

## Prerequisites

1. **Google Cloud Platform (GCP) Account**  
   Ensure you have a GCP account with necessary permissions to create resources.

2. **Install Terraform**  
   Terraform should be installed on your local machine. Follow the instructions on the [official Terraform site](https://www.terraform.io/downloads) to install it.

## Steps to Deploy

### 1. Create a Service Account (SA) in GCP Console

   - Navigate to the GCP Console.
   - Follow the instructions to create and configure a Service Account with the necessary roles by referring to the instructions in [this guide](https://github.com/Shabrinath/terraform-google-kubernetes-engine?tab=readme-ov-file#configure-a-service-account).

### 2. Generate and Download SA Keys

   - Generate a JSON key for the newly created Service Account.
   - Download the key file to your local machine.

### 3. Export the Google Credentials

   - Export the Service Account credentials to an environment variable:
     ```bash
     export GOOGLE_CREDENTIALS="/root/gcp_sa_creds.json"
     ```

### 4. Clone the Repository

   - Clone this repository to your local environment:
     ```bash
     git clone https://github.com/Shabrinath/gke-terraform.git
     ```

### 5. Set Up the Network

   - Navigate to the network configuration directory:
     ```bash
     cd gke-terraform/tf-network
     ```
   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Apply the network configuration:
     ```bash
     terraform apply
     ```

### 6. Set Up the GKE Cluster

   - Navigate to the GKE configuration directory:
     ```bash
     cd gke-terraform/tf-gke
     ```
   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Apply the GKE cluster configuration:
     ```bash
     terraform apply
     ```

---

## Notes

- Ensure your GCP Service Account has the necessary roles and permissions before proceeding.
- You can modify the Terraform variables to customize the network and GKE cluster settings as needed.

---

This guide should help you set up your GKE cluster and network using Terraform in a structured and efficient manner.

