include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/kkignasiak98/DataEngineeringFramework.git//infrastructure/modules/api?ref=infra"
}

inputs = {
  project_id = "gcp-data-engineering-dev" 
  gcp_region = "europe-west1"
  api_list = [
    # Core / IAM
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",

    # Compute & Networking (GKE nodes)
    "compute.googleapis.com",
    "container.googleapis.com",

    # Kubeflow / Vertex AI Pipelines
    "aiplatform.googleapis.com",
    "notebooks.googleapis.com",

    # BigQuery (ELT target)
    "bigquery.googleapis.com",
    "bigquerystorage.googleapis.com",
    "bigqueryconnection.googleapis.com",

    # Cloud Storage (staging / raw data lake)
    "storage.googleapis.com",
    "storage-component.googleapis.com",

    # Artifact Registry (container images for pipeline steps)
    "artifactregistry.googleapis.com",

    # Secret Manager (credentials management)
    "secretmanager.googleapis.com",

    # Logging & Monitoring
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}