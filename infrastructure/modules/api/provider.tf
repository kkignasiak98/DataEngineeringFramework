provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

terraform {
  required_providers {
    google = {
      source  = "opentofu/google"
      version = "~> 7.0"
    }
  }
}
