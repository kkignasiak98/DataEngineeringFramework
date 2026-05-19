variable "project_id" {
  type        = string
  default     = ""
  description = "The GCP project"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region"
  default     = "europe-west1"
}

variable "repository_id" {
  type        = string
  description = "The ID of the repository"
}

variable "description" {
  type        = string
  description = "Description of the repository"
  default     = "Artifact Registry repository for container images"
}

variable "format" {
  type        = string
  description = "The format of the repository (DOCKER, MAVEN, NPM, etc.)"
  default     = "DOCKER"
}

variable "labels" {
  type        = map(string)
  description = "Labels to apply to the repository"
  default     = {}
}
