data "terraform_remote_state" "remote_state_main" {
  backend = "s3"
  config = {
    bucket  = var.backend_s3_bucket
    key     = "copilot.tfstate"
    region  = var.region_aws
    profile = var.aws_profile
  }


module "copilot_build_aws" {
  source                   = "github.com/AviatrixSystems/terraform-modules-copilot.git//copilot_build_aws"
  keypair                  = "copilot_kp" # Name of generated keypair
  controller_public_ip     = var.controller_public_ip
  controller_private_ip    = var.controller_private_ip
  use_existing_vpc         = true
  vpc_id                   = var.controller_vpc_id
  subnet_id                = var.controller_subnet_id
  default_data_volume_name = var.copilot_data_volume_name
  default_data_volume_size = var.copilot_data_volume_size
  name_prefix              = var.naming_prefix
  instance_type            = var.copilot_instance_size

  allowed_cidrs = {} # Intentionally blank. SG rules will be managed separately, post-creation.

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

