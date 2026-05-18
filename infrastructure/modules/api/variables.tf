variable "project_id" {
  type        = string
  default     = ""
  description = "the GCP project"
}

variable "api_list" {
  type    = list(string)
  default = ["compute.googleapis.com", "iam.googleapis.com", "storage-component.googleapis.com"]
}

variable "gcp_region" {
  type        = string
  description = "The GCP region"
  default     = "europe-west1"
}