provider "google" {
  project = var.project_id
}

resource "random_string" "random_sic_key" {
  length = 12
  special = false
}

resource "random_string" "generated_password" {
  length = 12
  special = false
}
resource "random_string" "random_string" {
  length = 5
  special = false
  upper = false
  keepers = {}
}

locals {
  network_interfaces = [ for i, n in var.networks : {
    network     = n,
    subnetwork  = length(var.sub_networks) > i ? element(var.sub_networks, i) : null
    external_ip = length(var.external_ips) > i ? element(var.external_ips, i) : "NONE"
    }
  ]

  metadata = {
    External = "External network"
    Internal = "Internal network"
    google-logging-enable = "0"
    google-monitoring-enable = "0"
  }
}

resource "google_compute_instance" "instance" {
  name = "${var.goog_cm_deployment_name}-vm"
  machine_type = var.machine_type
  zone = var.zone

  tags = ["${var.goog_cm_deployment_name}-deployment"]

  boot_disk {
    device_name = "autogen-vm-tmpl-boot-disk"

    initialize_params {
      size = var.boot_disk_size
      type = var.boot_disk_type
      image = var.source_image
    }
  }

  can_ip_forward = var.ip_forward

  metadata = local.metadata

  dynamic "network_interface" {
    for_each = local.network_interfaces
    content {
      network = network_interface.value.network
      subnetwork = network_interface.value.subnetwork

      dynamic "access_config" {
        for_each = network_interface.value.external_ip == "NONE" ? [] : [1]
        content {
          nat_ip = network_interface.value.external_ip == "EPHEMERAL" ? null : network_interface.value.external_ip
        }
      }
    }
  }

  service_account {
    email = "default"
    scopes = compact([
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ])
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh", {
    // script's arguments
    generatePassword = var.generate_password
    config_url = ""
    config_path = ""
    sicKey = ""
    allowUploadDownload = var.allow_download_upload
    templateName = "autoscale_tf"
    templateVersion = "20250217"
    templateType = "terraform"
    mgmtNIC = var.management_interface
    hasInternet = "false"
    enableMonitoring = var.enable_stackdriver_monitoring
    shell = var.admin_shell
    installation_type = "AutoScale"
    computed_sic_key = random_string.random_sic_key.result
    managementGUIClientNetwork = ""
    primary_cluster_address_name = ""
    secondary_cluster_address_name = ""
    managementNetwork = ""
    numAdditionalNICs = ""
    smart_1_cloud_token = ""
    name = ""
    zoneConfig = ""
    region = ""
    os_version = var.os_version
    maintenance_mode_password_hash = var.maintenance_mode_password
  })
}
