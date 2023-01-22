# Launch Copilot in AWS

### Provider Block:
``` hcl
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

# Do not hardcode credentials
provider "aviatrix" {
  controller_ip           = var.controller_public_ip
  skip_version_validation = true
}

provider "aws" {}
```
