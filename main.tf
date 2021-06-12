# terraform-docker-stevebot - main.tf

data "docker_registry_image" "this" {
  name = "${var.image_source}:${var.image_version}"
}

resource "docker_image" "this" {
  name          = data.docker_registry_image.this.name
  pull_triggers = [data.docker_registry_image.this.sha256_digest]
}

resource "random_uuid" "this" {}

resource "docker_container" "this" {
  name  = local.container_name
  image = docker_image.this.latest

  env = [for k, v in local.env : "${k}=${v}" if v != ""]

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

  allowed_commands   = join(",", var.allowed_commands)
  forbidden_commands = join(",", var.forbidden_commands)

  env = {
    STEVEBOT_RCON_HOST          = var.rcon_host
    STEVEBOT_RCON_PORT          = var.rcon_port
    STEVEBOT_RCON_PASSWORD      = var.rcon_password
    STEVEBOT_DISCORD_TOKEN      = var.discord_token
    STEVEBOT_COMMAND_PREFIX     = var.command_prefix
    STEVEBOT_ALLOWED_COMMANDS   = local.allowed_commands
    STEVEBOT_FORBIDDEN_COMMANDS = local.forbidden_commands
  }
}
