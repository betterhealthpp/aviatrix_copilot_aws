# Gather spoke and transit gateway information from Controller:
data "aviatrix_spoke_gateways" "spokes" {}
data "aviatrix_transit_gateways" "transits" {}

locals {
  spoke_private_cidrs   = [for x in data.aviatrix_spoke_gateways.spokes.gateway_list[*].private_ip : "${x}/32"]
  transit_private_cidrs = [for x in data.aviatrix_transit_gateways.transits.gateway_list[*].private_ip : "${x}/32"]
}

output "spoke_prvt_cidrs" {
  value = local.spoke_private_cidrs
}

output "transit_prvt_cidrs" {
  value = local.transit_private_cidrs
}

module "copilot_build_aws" {
  source                   = "github.com/AviatrixSystems/terraform-modules-copilot.git//copilot_build_aws"
  keypair                  = "copilot_kp"
  controller_public_ip     = var.controller_public_ip
  controller_private_ip    = var.controller_private_ip
  use_existing_vpc         = true
  vpc_id                   = var.controller_vpc_id
  subnet_id                = var.controller_subnet_id
  default_data_volume_name = var.copilot_data_volume_name
  default_data_volume_size = var.copilot_data_volume_size


    # Copilot SGs aren't updating when changes are made here. May need to start with basic "allowed_cidrs" list, then create separate resource block to manage new CIDRs (would also allow for manging src/dest ports for UDP)
  allowed_cidrs = {
    "HTTPS_access" = {
      protocol = "tcp"
      port     = "443"
      cidrs    = [for n in var.allowed_cidrs_https : n]
    }

    "spoke_private_cidrs_syslog" = {
      protocol = "udp"
      port     = 5000 #need to specify source and destination ports, as UDP src/dest ports differ
      cidrs    = [for n in local.spoke_private_cidrs : n]
    }

    "spoke_private_cidrs_netflow" = {
      protocol = "udp"
      port     = 31283 #need to specify source and destination ports, as UDP src/dest ports differ
      cidrs    = [for n in local.spoke_private_cidrs : n]
    }

    "transit_private_cidrs_syslog" = {
      protocol = "udp"
      port     = 5000
      cidrs    = [for n in local.transit_private_cidrs : n]
    }

    "transit_private_cidrs_syslog" = {
      protocol = "udp"
      port     = 31283
      cidrs    = [for n in local.transit_private_cidrs : n]
    }

    # If entering Spoke and Transit GW addresses manually, use the following block instead of "spoke_private_cidrs" and "transit_private_cidrs":
    # "avx_gateway_private_ip_addresses_syslog" = {
    #   protocol = "udp"
    #   port    = 5000
    #   cidrs   = [for n in var.allowed_cidrs_syslog_netflow : n]
    # }
    # "avx_gateway_private_ip_addresses_netflow" = {
    #   protocol = "udp"
    #   port    = 31283
    #   cidrs   = [for n in var.allowed_cidrs_syslog_netflow : n]
    # }

  }

  #   additional_volumes = {
  #     "one" = {
  #       device_name = "<< device name 1 >>"
  #       volume_id = "<< volume id 1 >>"
  #     }
  #     "two" = {
  #       device_name = "<< device name 2 >>"
  #       volume_id = "<< volume id 2 >>"
  #     }
  #   }
}

output "copilot_private_ip" {
  value = module.copilot_build_aws.private_ip
}

output "copilot_public_ip" {
  value = module.copilot_build_aws.public_ip
}