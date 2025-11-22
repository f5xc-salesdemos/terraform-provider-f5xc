# Voltstack Site Resource Example
# Shape of the App Stack site specification

# Basic Voltstack Site configuration
resource "f5xc_voltstack_site" "example" {
  name      = "my-voltstack-site"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Voltstack Site configuration
  # Kubernetes configuration
  k8s_cluster {
    name      = "my-k8s-cluster"
    namespace = "system"
  }

  # Master nodes configuration
  master_nodes = ["master1.example.com"]

  # Default fleet configuration
  default_fleet_config {
    no_bond_devices {}
    no_dc_cluster_group {}
    default_storage_config {}
    no_gpu {}
  }

  # Disable HA by default
  disable_ha {}

  # No worker nodes
  no_worker_nodes {}
}

# Advanced Voltstack Site with additional configuration
resource "f5xc_voltstack_site" "advanced" {
  name      = "advanced-voltstack-site"
  namespace = "system"

  labels = {
    environment = "staging"
    team        = "platform"
    cost_center = "engineering"
  }

  annotations = {
    "created_by" = "terraform"
    "version"    = "2.0"
  }
}
