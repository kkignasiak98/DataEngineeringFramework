variable "project_id" {
  type        = string
  description = "The GCP project where the custom role will be created."
}

variable "role_id" {
  type        = string
  description = "ID of the custom role (must be unique within the project)."
  default     = "pipelineRunner"
}

variable "title" {
  type        = string
  description = "Human-readable title of the custom role."
  default     = "Pipeline Runner"
}

variable "description" {
  type        = string
  description = "Description of the custom role."
  default     = "Custom role with permissions required to run ELT pipelines on GKE/Kubeflow (Vertex AI Pipelines) and read/write data in BigQuery and GCS."
}

variable "members" {
  type        = list(string)
  description = "Optional list of members to bind to the custom role (e.g. serviceAccount:foo@project.iam.gserviceaccount.com)."
  default     = []
}

variable "stage" {
  type        = string
  description = "Launch stage of the custom role."
  default     = "GA"
}
