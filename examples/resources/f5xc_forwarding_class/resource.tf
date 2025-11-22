# Forwarding Class Resource Example
# Forwarding Class is created by users in system namespace

# Basic Forwarding Class configuration
resource "f5xc_forwarding_class" "example" {
  name      = "my-forwarding-class"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # DSCP Marking setting. DSCP marking setting as per RFC 2475
    dscp {
      # Configure dscp settings
    }
    # Empty. This can be used for messages where no values are ...
    dscp_based_queue {
      # Configure dscp_based_queue settings
    }
    # Empty. This can be used for messages where no values are ...
    no_marking {
      # Configure no_marking settings
    }
}
