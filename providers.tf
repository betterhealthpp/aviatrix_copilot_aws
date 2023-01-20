terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aviatrix" {
  controller_ip           = var.controller_public_ip
  username                = var.controller_username
  password                = var.controller_password
  skip_version_validation = true
}

provider "aws" {
  region     = var.region_aws
  access_key = var.ak_aws
  secret_key = var.sak_aws
}
