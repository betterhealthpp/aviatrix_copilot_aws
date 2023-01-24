variable "region_aws" {
  type        = string
  description = "AWS region where Controller exists"
}

variable "prefix" {
  type        = string
  description = "Name prefix for Copilot instance name, security group(s), etc. If no prefix is required, use two double quotes."
  default     = ""
}

variable "copilot_instance_size" {
  type        = string
  description = "Copilot EC2 type"
  default     = "" # The empty quotes will default to m5.2xlarge in the module.
}

# Optional {
variable "ak_aws" {
  type        = string
  sensitive   = true
  description = "AWS access key"
}

variable "sak_aws" {
  type        = string
  sensitive   = true
  description = "AWS secret access key"
}
# } 

variable "controller_public_ip" {
  type      = string
  sensitive = true
}

variable "controller_private_ip" {
  type      = string
  sensitive = true
}

variable "controller_username" {
  type      = string
  sensitive = true
}

variable "controller_password" {
  type      = string
  sensitive = true
}

variable "controller_vpc_id" {
  type      = string
  sensitive = true
}

variable "controller_subnet_id" {
  type      = string
  sensitive = true
}

variable "allowed_cidrs_https" {
  type = list(string)
}

variable "allowed_cidrs_syslog_netflow" {
  type = list(string)
}

variable "copilot_data_volume_name" {
  type = string
}

variable "copilot_data_volume_size" {
  type = number
}