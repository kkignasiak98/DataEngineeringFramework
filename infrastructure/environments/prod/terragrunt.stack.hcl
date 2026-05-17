###############################################################################
# Prod environment stack
#
# Composes the reusable units from `infrastructure/units/` into a deployable
# stack. Run from this directory:
#
#   terragrunt stack generate    # materialise units into .terragrunt-stack/
#   terragrunt stack run apply   # deploy all units
###############################################################################

locals {
  project_id = "savvy-generator-496607-t8"
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

unit "api" {
  # Local path to the catalog while iterating before publishing to the
  # `infra` branch. Switch back to:
  #   "git::https://github.com/kkignasiak98/DataEngineeringFramework.git//infrastructure/units/api?ref=infra"
  # once the catalog has been pushed.
  source = "../../units/api"
  path   = "api"

  values = {
    project_id = local.project_id
    gcp_region = local.gcp_region
    api_list   = local.api_list
  }
}

unit "pipeline_runner_role" {
  # Local path to the catalog while iterating before publishing to the
  # `infra` branch. Switch back to:
  #   "git::https://github.com/kkignasiak98/DataEngineeringFramework.git//infrastructure/units/pipeline_runner_role?ref=infra"
  # once the catalog has been pushed.
  source = "../../units/pipeline_runner_role"
  path   = "pipeline_runner_role"

  values = {
    project_id = local.project_id

    # Relative path to the sibling `api` unit inside the generated stack.
    # The unit's `dependency "api"` block consumes this so APIs are enabled
    # before the custom role is created.
    api_path = "../api"

    role_id     = "pipelineRunner"
    title       = "Pipeline Runner"
    description = "Custom role with permissions required to run ELT pipelines on GKE/Kubeflow (Vertex AI Pipelines) and read/write data in BigQuery and GCS."
  }
}
