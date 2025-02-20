# Google Cloud Marketplace Terraform Module

This module deploys a product from Google Cloud Marketplace.

## Usage
The provided test configuration can be used by executing:

```
terraform plan --var-file marketplace_test.tfvars --var project_id=<YOUR_PROJECT>
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The ID of the project in which to provision resources. | `string` | `null` | yes |
| goog_cm_deployment_name | The name of the deployment and VM instance. | `string` | `null` | yes |
| source_image | The image name for the disk for the VM instance. | `string` | `"projects/checkpoint-public/global/images/check-point-r8120-gw-byol-mig-631-991001732-v20250108"` | no |
| zone | The zone for the solution to be deployed. | `string` | `"us-central1-a"` | no |
| machine_type | The machine type to create, e.g. e2-small | `string` | `"n1-standard-4"` | no |
| boot_disk_type | The boot disk type for the VM instance. | `string` | `"pd-ssd"` | no |
| boot_disk_size | The boot disk size for the VM instance in GBs | `number` | `100` | no |
| networks | The network name to attach the VM instance. | `list(string)` | `["default"]` | no |
| sub_networks | The sub network name to attach the VM instance. | `list(string)` | `[]` | no |
| external_ips | The external IPs assigned to the VM for public access. | `list(string)` | `["EPHEMERAL"]` | no |
| ip_forward | Whether to allow sending and receiving of packets with non-matching source or destination IPs. | `bool` | `false` | no |
| os_version | Gaia OS version | `string` | `"R8120"` | no |
| management_interface | Autoscaling Security Gateways in GCP can be managed by an ephemeral public IP or using the private IP of the internal interface (eth1). | `string` | `"Ephemeral Public IP (eth0)"` | no |
| security_management_server_name | The name of the Security Management Server as appears in autoprovisioning configuration | `string` | `"checkpoint-management"` | no |
| configuration_template_name | Specify the provisioning configuration template name (for autoprovisioning) | `string` | `"gcp-asg-autoprov-tmplt"` | no |
| public_ssh_key | This key will be used to connect to every gateway instance created by the managed instance group. This key will replace all project-wide SSH keys | `string` | `null` | no |
| network_defined_by_routes | Set eth1 topology to define the networks behind this interface by the routes configured on the gateway | `bool` | `true` | no |
| admin_shell | Change the admin shell to enable advanced command line configuration. | `string` | `"/etc/cli.sh"` | no |
| allow_download_upload | Approve to automatically download product updates and to share statistical data with Check Point for product improvement purpose. For more information see sk111080 | `bool` | `true` | no |
| generate_password | To manage the environment's security, administrators can connect to the Management Server with SmartConsole clients and via the Gaia WebUI using this password | `bool` | `false` | no |
| maintenance_mode_password | Check Point recommends setting serial console password and maintenance-mode password for recovery purposes | `string` | `null` | no |
| enable_stackdriver_monitoring |  | `bool` | `false` | no |
| min_instance |  | `number` | `2` | no |
| max_instance |  | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_self_link | Self-link for the compute instance. |
| instance_zone | Zone for the compute instance. |
| instance_machine_type | Machine type for the compute instance. |
| instance_nat_ip | External IP of the compute instance. |
| instance_network | Self-link for the network of the compute instance. |

## Requirements
### Terraform

Be sure you have the correct Terraform version (1.2.0+), you can choose the binary here:

https://releases.hashicorp.com/terraform/

### Configure a Service Account
In order to execute this module you must have a Service Account with the following project roles:

- `roles/compute.admin`
- `roles/iam.serviceAccountUser`

If you are using a shared VPC:

- `roles/compute.networkAdmin` is required on the Shared VPC host project.

### Enable API
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - `compute.googleapis.com`
