variable "region_aws" {
  type        = string
  description = "AWS region where Controller exists"
}

variable "naming_prefix" {
  type        = string
  description = "Optional: Prefix for Copilot instance name, security group(s), etc."
  default     = ""
}

variable "copilot_instance_size" {
  type        = string
  description = "Copilot EC2 type"
  default     = "" # The empty quotes will default to m5.2xlarge in the module.
}

variable "access_key_aws" {
  type        = string
  sensitive   = true
  description = "AWS access key"
}

variable "secret_access_key_aws" {
  type        = string
  sensitive   = true
  description = "AWS secret access key"
}

variable "controller_public_ip" {
  type        = string
  sensitive   = true
  description = "Aviatrix Controller Public IPv4 address."
}

variable "controller_private_ip" {
  type        = string
  sensitive   = true
  description = "Aviatrix Controller Private IPv4 address."
}

variable "controller_username" {
  type        = string
  sensitive   = true
  description = "Username to access Aviatrix Controller."
}

variable "controller_password" {
  type        = string
  sensitive   = true
  description = "Password associated with username."
}

variable "controller_vpc_id" {
  type        = string
  sensitive   = true
  description = "AWS VPC ID of Controller."
}

variable "controller_subnet_id" {
  type        = string
  sensitive   = true
  description = "AWS Subnet ID of Controller instance."
}

variable "allowed_cidrs_https" {
  type        = list(string)
  description = "List of CIDRs that will access Copilot via HTTPS (e.g. users' desktop IPv4 addresses)"
}

variable "copilot_data_volume_name" {
  type        = string
  description = "Copliot data volume name. Must be a valid EBS volume name (/dev/sd[f-p])"
  default     = "/dev/sdf"
}

variable "copilot_data_volume_size" {
  type        = number
  description = "Copilot data volume size in GB."
  default     = 30
}