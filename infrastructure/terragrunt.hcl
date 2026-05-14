locals {
  project_ID          = "kkignasiak-code-miracles"
  resource_location   = "europe-west1"

}


# Terragrunt configuration
remote_state {
  backend = "local"
  config = {
    path = "terraform.tfstate"
  }
}


# Generate the provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "${local.project_ID}"
  region  = "${local.resource_location}"
}

terraform {
  required_providers {
    google = {
      source  = "opentofu/google"
      version = "~> 7.0"
    }
  }
}
EOF
}