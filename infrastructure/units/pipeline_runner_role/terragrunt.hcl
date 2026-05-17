###############################################################################
# Unit: pipeline_runner_role
#
# Creates the `pipelineRunner` custom IAM role in the target GCP project.
# The role bundles all permissions needed to run ELT jobs on
# GKE/Kubeflow (Vertex AI Pipelines) and read/write data in BigQuery and GCS.
#
# Consumed by a parent `terragrunt.stack.hcl` via:
#
#   unit "pipeline_runner_role" {
#     source = "...units/pipeline_runner_role?ref=..."
#     path   = "pipeline_runner_role"
#     values = {
#       project_id = "..."
#       api_path   = "../api"
#     }
#   }
#
# The `api_path` value points at the sibling `api` unit so that the required
# GCP APIs (iam.googleapis.com, ...) are enabled before this role is created.
###############################################################################

terraform {
  source = "git::https://github.com/kkignasiak98/DataEngineeringFramework.git//infrastructure/modules/pipeline_runner_role?ref=infra"
}

# Make sure the required GCP APIs are enabled before the custom role is
# created. The `config_path` is provided as a value from the stack so the
# unit stays portable.
dependency "api" {
  config_path = values.api_path

  mock_outputs                            = {}
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init"]
}

inputs = {
  project_id  = values.project_id
  role_id     = try(values.role_id, "pipelineRunner")
  title       = try(values.title, "Pipeline Runner")
  description = try(values.description, "Custom role with permissions required to run ELT pipelines on GKE/Kubeflow (Vertex AI Pipelines) and read/write data in BigQuery and GCS.")
  members     = try(values.members, [])
}
