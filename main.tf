# terraform-docker-stevebot - main.tf

data "docker_registry_image" "this" {
  name = "${var.image_source}:${image_version}"
}

resource "docker_image" "this" {
  name          = data.docker_registry_image.this.name
  pull_triggers = [data.docker_registry_image.this.sha256_digest]
}

resource "random_uuid" "this" {}

resource "docker_container" "this" {
  name  = local.container_name
  image = docker_image.this.latest

  env = [
    "STEVEBOT_TOKEN=${var.stevebot_token}",
    "STEVEBOT_COMMAND_PREFIX=${var.stevebot_command_prefix}",
    "STEVEBOT_RCON_HOST=${var.rcon_host}",
    "STEVEBOT_RCON_PORT=${var.rcon_port}",
    "STEVEBOT_RCON_PASS=${var.rcon_password}",
  ]

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      label = label.key
      value = label.value
    }
  }

  must_run = true
  restart  = var.restart
  start    = var.start
}

locals {
  container_name = var.container_name != "" ? var.container_name : (
    "stevebot_${random_uuid.this.result}"
  )
}