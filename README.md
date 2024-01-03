# Website Deployment with Google Cloud Services and Terraform

Overview

This repository contains Terraform configuration files to deploy a highly available and scalable website on Google Cloud Platform (GCP) using the following services:

Cloud DNS
Cloud CDN
Load Balancer
Cloud Storage

Prerequisite
1. A Google Cloud Platform account with billing enabled
2. Terraform installed on your local machine
3. Google Cloud SDK installed and authenticated


# Clone this repository
git clone https://github.com/lakkawardhananjay/terraformfirstwebdeploy.git

# Configure Terraform variables:

Create a terraform.tfvars file or set environment variables with the following values:

project_id: Your GCP project ID

region: The GCP region where you want to deploy the resources (e.g., us-central1)

domain_name: The domain name you want to use for your website (e.g., www.example.com)

bucket_name: The name of the Cloud Storage bucket to store your website content

# Initialize Terraform

terraform init:
    prepares a working directory for other commands by setting up plugins, modules, and backend configurations.

terraform plan:
    creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.

terraform apply:
     executes the actions proposed in a Terraform plan

# **Terraform Configuration**
The main configuration files in this repository are:
main.tf: Contains the core configuration for the website deployment.
variables. tf: Defines variables that can be customized for your specific deployment.


Testing: To test your website, access it using the assigned load balancer IP address or domain name.
Updating: Make changes to the Terraform configuration files and re-run Terraform apply to update the infrastructure.
Destroying: To remove the deployed resources, run terraform destroy.
#Best Practices
Refer to the Terraform documentation for troubleshooting assistance.
Check the GCP console for logs and error messages.
Seek help from the Terraform community or GCP support channels if needed.
