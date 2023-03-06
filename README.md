# AWS: Launch Aviatrix Copilot in Controller Subnet with Terraform
These Terraform scripts leverage the Aviatrix Systems Copilot delpoyment in AWS module. 
However, this deployment will, by default, launch Copilot in the same subnet as the existing Controller.
Additionally, this deployment allows the private IPv4 addresses of the Aviatrix spoke and transit gateways to reach the Copilot instance without the need for manual input. Any external addresses that will need to reach the Copilot instance via HTTPS will need to be configured manually in the `allowed_cidrs_https` variable (those addresses can be modified after Copilot is deployed).

## Prerequsites

### Terraform version
Terraform 0.14 or greater is required due to the use of sensitive variable flags.

### Variable management

#### Prerequisite Option #1: terraform.tfvars file
Copy block below to a terraform.tfvars file and assign values to the following variables (do not push to repository):

``` hcl
profile_aws		 =
backend_s3_bucket	 =
region_aws		 =
controller_username      = 
controller_password      = 
controller_public_ip     = 
controller_private_ip    = 
controller_vpc_id        = 
controller_subnet_id     = 
naming_prefix            = 
copilot_instance_size    = 
copilot_data_volume_name = 
copilot_data_volume_size = 
allowed_cidrs_https = [
  "1.1.1.1/32", #Example
]
```

#### Prerequisite Option #2: Environment Variables
If having AWS and Aviatrix Credentials in terraform.tfvars file is undesirable, configure the more sensitive values as environment variables in the terminal and set the remaining variables in a terraform.tfvars file. For example:
``` sh
export TF_VAR_profile_aws="__"
export TF_VAR_backend_s3_bucket="__"
export TF_VAR_controller_public_ip="__"
export TF_VAR_controller_username="__"
export TF_VAR_controller_password="__"
```

|   Variable                 | Description    | Default Value |
|     ---                    |     ---        |       ---     |
| `profile_aws`           | AWSCLI Profile - https://registry.terraform.io/providers/hashicorp/aws/latest/docs#AWS_PROFILE | N/A |
| `backend_s3_bucket`        | S3 bucket to store remote state in (must be accessible using the `profile_aws` specified) | N/A |
|  `region_aws`              | AWS region where Controller and remote state S3 bucket exist | N/A |
|  `controller_username`     | Username to access Aviatrix Controller | N/A|
|  `controller_password`     | Password associated with username | N/A |
| `controller_public_ip`     | Aviatrix Controller Public IPv4 address   | N/A | 
| `controller_private_ip`    | Aviatrix Controller Private IPv4 address  | N/A |
| `controller_vpc_id`        | Controller VPC ID in AWS | N/A |
| `controller_subnet_id`     | Controller Subnet ID in AWS | N/A |
| `naming_prefix`            | Optional: Prefix for Copilot instance name, security group(s), etc. | "" |
| `copilot_instance_size`    | Copilot EC2 type | if left blank (`""`) m5.2xlarge will be used |
| `copilot_data_volume_name` | Copliot data volume name. Must be a valid EBS volume name (/dev/sd[f-p]) | "/dev/sdf" |
| `copilot_data_volume_size` | Copilot data volume size in GB (type = number) | 30 |
| `allowed_cidrs_https`      | List of CIDRs that will access Copilot via HTTPS (e.g. users' desktop IPv4 addresses) | N/A |
