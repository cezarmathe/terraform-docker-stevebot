# terraform-docker-stevebot - variables.tf

variable "image_source" {
  type        = string
  description = <<-DESCRIPTION
  The source of the stevebot container image. By default, this uses the container image built by the
  author of this module.
  DESCRIPTION
  default     = "cezarmathe/stevebot"
}

variable "image_version" {
  type        = string
  description = <<-DESCRIPTION
  Container image version.
  DESCRIPTION
  default     = "latest"
}

variable "start" {
  type        = bool
  description = "Whether to start the container or just create it."
  default     = true
}

variable "restart" {
  type        = string
  description = <<-DESCRIPTION
  The restart policy of the container. Must be one of: "no", "on-failure", "always",
  "unless-stopped".
  DESCRIPTION
  default     = "unless-stopped"
}

variable "container_name" {
  type        = string
  description = <<-DESCRIPTION
  The name of the transmission container. If empty, one will be generated like this:
  'stevebot_{random-uuid}'.
  DESCRIPTION
  default     = ""
}

variable "labels" {
  type        = map(string)
  description = "Labels to attach to created resources that support labels."
  default     = {}
}

variable "stevebot_token" {
  type        = string
  description = "Discord token used by this bot."
}

variable "stevebot_command_prefix" {
  type        = string
  description = "Command prefix used by this bot."
  default     = "~"
}

variable "rcon_host" {
  type        = string
  description = "Host to connect to via rcon."
  default     = "127.0.0.1"
}

variable "rcon_port" {
  type        = number
  description = "Port to connect to via rcon."
  default     = 25575
}

variable "rcon_password" {
  type        = string
  description = "Password to use when connecting to the host via rcon."
}
