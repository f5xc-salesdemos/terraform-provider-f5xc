# Securemesh Site Resource Example
# Shape of the Secure Mesh site specification

# Basic Securemesh Site configuration
resource "f5xc_securemesh_site" "example" {
  name      = "my-securemesh-site"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Secure Mesh Site configuration
  # Generic provider
  generic {
    not_managed {
      node_list {
        hostname  = "node1.example.com"
        public_ip = "203.0.113.10"
        type      = "Control"
      }
    }
  }

  # Master nodes
  master_nodes_count = 1

  # Default fleet config
  default_fleet_config {}

  # Disable HA
  disable_ha {}
}

# Advanced Securemesh Site with additional configuration
resource "f5xc_securemesh_site" "advanced" {
  name      = "advanced-securemesh-site"
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
