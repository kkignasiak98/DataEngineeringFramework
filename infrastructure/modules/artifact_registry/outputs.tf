output "repository_id" {
  description = "The ID of the repository"
  value       = google_artifact_registry_repository.repository.repository_id
}

output "repository_name" {
  description = "The name of the repository"
  value       = google_artifact_registry_repository.repository.name
}

output "repository_location" {
  description = "The location of the repository"
  value       = google_artifact_registry_repository.repository.location
}
