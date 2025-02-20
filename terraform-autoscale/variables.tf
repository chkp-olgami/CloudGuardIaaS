variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

// Marketplace requires this variable name to be declared
variable "goog_cm_deployment_name" {
  description = "The name of the deployment and VM instance."
  type        = string
}

variable "source_image" {
  description = "The image name for the disk for the VM instance."
  type        = string
  default     = "projects/checkpoint-public/global/images/check-point-r8120-gw-byol-mig-631-991001732-v20250108"
}

variable "zone" {
  description = "The zone for the solution to be deployed."
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type to create, e.g. e2-small"
  type        = string
  default     = "n1-standard-4"
}

variable "boot_disk_type" {
  description = "The boot disk type for the VM instance."
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "The boot disk size for the VM instance in GBs"
  type        = number
  default     = 100
}

variable "networks" {
  description = "The network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "sub_networks" {
  description = "The sub network name to attach the VM instance."
  type        = list(string)
  default     = []
}

variable "external_ips" {
  description = "The external IPs assigned to the VM for public access."
  type        = list(string)
  default     = ["EPHEMERAL"]
}

variable "ip_forward" {
  description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs."
  type        = bool
  default     = false
}

variable "os_version" {
  description = "Gaia OS version"
  type        = string
  default     = "R8120"
}

variable "management_interface" {
  description = "Autoscaling Security Gateways in GCP can be managed by an ephemeral public IP or using the private IP of the internal interface (eth1)."
  type        = string
  default     = "Ephemeral Public IP (eth0)"
}

variable "security_management_server_name" {
  description = "The name of the Security Management Server as appears in autoprovisioning configuration"
  type        = string
  default     = "checkpoint-management"
}

variable "configuration_template_name" {
  description = "Specify the provisioning configuration template name (for autoprovisioning)"
  type        = string
  default     = "gcp-asg-autoprov-tmplt"
}

variable "public_ssh_key" {
  description = "This key will be used to connect to every gateway instance created by the managed instance group. This key will replace all project-wide SSH keys"
  type        = string
  default     = ""
}

variable "network_defined_by_routes" {
  description = "Set eth1 topology to define the networks behind this interface by the routes configured on the gateway"
  type        = bool
  default     = true
}

variable "admin_shell" {
  description = "Change the admin shell to enable advanced command line configuration."
  type        = string
  default     = "/etc/cli.sh"
}

variable "allow_download_upload" {
  description = "Approve to automatically download product updates and to share statistical data with Check Point for product improvement purpose. For more information see sk111080"
  type        = bool
  default     = true
}

variable "generate_password" {
  description = "To manage the environment's security, administrators can connect to the Management Server with SmartConsole clients and via the Gaia WebUI using this password"
  type        = bool
  default     = false
}

variable "maintenance_mode_password" {
  description = "Check Point recommends setting serial console password and maintenance-mode password for recovery purposes"
  type        = string
  default     = ""
}

variable "enable_stackdriver_monitoring" {
  type        = bool
  default     = false
}

variable "min_instance" {
  type        = number
  default     = 2
}

variable "max_instance" {
  type        = number
  default     = 10
}
