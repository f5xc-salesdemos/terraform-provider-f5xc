# Infraprotect Firewall Rule Resource Example
# Creates a DDoS transit Firewall Rule

# Basic Infraprotect Firewall Rule configuration
resource "f5xc_infraprotect_firewall_rule" "example" {
  name      = "my-infraprotect-firewall-rule"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Empty. This can be used for messages where no values are ...
    action_allow {
      # Configure action_allow settings
    }
    # Empty. This can be used for messages where no values are ...
    action_deny {
      # Configure action_deny settings
    }
    # Empty. This can be used for messages where no values are ...
    destination_prefix_all {
      # Configure destination_prefix_all settings
    }
}
