###############################################################################
# Unit: api
#
# Enables the set of GCP APIs required to run the platform in a project.
# Consumed by a parent `terragrunt.stack.hcl` via:
#
#   unit "api" {
#     source = "...units/api?ref=..."
#     path   = "api"
#     values = {
#       project_id = "..."
#       gcp_region = "..."
#       api_list   = [ ... ]
#     }
#   }
#
# Terragrunt generates a `terragrunt.values.hcl` next to this file, exposing
# the `values.*` variables used below.
###############################################################################

terraform {
  source = "git::https://github.com/kkignasiak98/DataEngineeringFramework.git//infrastructure/modules/api?ref=infra"
}

inputs = {
  project_id = values.project_id
  gcp_region = values.gcp_region
  api_list   = values.api_list
}
