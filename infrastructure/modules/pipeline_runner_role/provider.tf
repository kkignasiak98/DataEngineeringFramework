provider "google" {
  project = var.project_id
}

terraform {
  required_providers {
    google = {
      source  = "opentofu/google"
      version = "~> 7.0"
    }
  }
}
