output "custom_role_id" {
  description = "ID of the custom role created."
  value       = module.pipeline_runner_role.custom_role_id
}

output "custom_role_name" {
  description = "Fully-qualified name of the custom role, suitable for IAM bindings."
  value       = module.pipeline_runner_role.custom_role_name
}
