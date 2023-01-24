# AWS: Launch Aviatrix Copilot in Controller Subnet

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
  "1.1.1.1/32   #Example
]
```

|   Variable              | Description | Default Value |
|     ---                 |     ---     |       ---     |
| `access_key_aws`        |             |               |
| `secret_access_key_aws` |             |               |
|  `controller_username`  |             |               |
|  `controller_password`  |             |               |
|  `region_aws`           |             |               |