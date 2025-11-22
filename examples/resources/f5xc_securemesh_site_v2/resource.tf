# Securemesh Site V2 Resource Example
# Shape of the Secure Mesh site specification

# Basic Securemesh Site V2 configuration
resource "f5xc_securemesh_site_v2" "example" {
  name      = "my-securemesh-site-v2"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Active Enhanced Network Policies Type. List of Enhanced F...
    active_enhanced_firewall_policies {
      # Configure active_enhanced_firewall_policies settings
    }
    # Enhanced Firewall Policy. Ordered List of Enhanced Firewa...
    enhanced_firewall_policies {
      # Configure enhanced_firewall_policies settings
    }
    # Active Forward Proxy Policies Type. Ordered List of Forwa...
    active_forward_proxy_policies {
      # Configure active_forward_proxy_policies settings
    }
}

# Advanced Securemesh Site V2 with additional configuration
resource "f5xc_securemesh_site_v2" "advanced" {
  name      = "advanced-securemesh-site-v2"
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
