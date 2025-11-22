# Network Firewall Resource Example
# network firewall is created by users in system namespace

# Basic Network Firewall configuration
resource "f5xc_network_firewall" "example" {
  name      = "my-network-firewall"
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
    # Active Fast ACL(s). List of Fast ACL(s).
    active_fast_acls {
      # Configure active_fast_acls settings
    }
}
