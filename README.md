# AWS: Launch Aviatrix Copilot in Controller Subnet with Terraform
## This 

### Prerequisite Option #1: Configure the Following Environment Variables in the Terminal:
``` sh
export TF_VAR_access_key_aws="__"
export TF_VAR_secret_access_key_aws="__"
export TF_VAR_controller_public_ip="__"
export TF_VAR_controller_username="__"
export TF_VAR_controller_password="__"
```

### Prerequisite Option #2: Copy block below to a terraform.tfvars file and assign values to the following variables (do not push to repository):
``` hcl
access_key_aws           = 
secret_access_key_aws    = 
controller_username      = 
controller_password      = 
region_aws               = 
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

|   Variable                 | Description    | Default Value |
|     ---                    |     ---        |       ---     |
| `access_key_aws`           | AWS access key | N/A |
| `secret_access_key_aws`    | AWS secret access key | N/A |
|  `controller_username`     | Username to access Aviatrix Controller | N/A|
|  `controller_password`     | Password associated with username | N/A |
|  `region_aws`              | AWS region where Controller exists | N/A |
| `controller_public_ip`     | Aviatrix Controller Public IPv4 address   | N/A | 
| `controller_private_ip`    | Aviatrix Controller Private IPv4 address  | N/A |
| `controller_vpc_id`        | AWS VPC ID of Controller | N/A |
| `controller_subnet_id`     | AWS Subnet ID of Controller instance | N/A |
| `naming_prefix`            | Optional: Prefix for Copilot instance name, security group(s), etc. | "" |
| `copilot_instance_size`    | Copilot EC2 type | if left blank (`""`) m5.2xlarge will be used |
| `copilot_data_volume_name` | Copliot data volume name. Must be a valid EBS volume name (/dev/sd[f-p]) | N/A |
| `copilot_data_volume_size` | Copilot data volume size in GB (type = number) | 30 |
| `allowed_cidrs_https`      | List of CIDRs that will access Copilot via HTTPS (e.g. users' desktop IPv4 addresses) | N/A |