# terraform-docker-stevebot - outputs.tf

output "this_name" {
  description = "Name of the container."
  value       = docker_container.this.name
}

output "this_uuid" {
  description = "The random uuid used for naming the resources created by this module."
  value       = random_uuid.this.result
}
